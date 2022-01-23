//
//  RegisterService.swift
//  Next Gaymer
//
//  Created by Fabien Saint Germain on 14/01/2022.
//

import Firebase
import FirebaseFirestoreSwift
import GoogleSignIn
import UIKit

class FirebaseUserService {

  private let db = Firestore.firestore()
  private let auth = Auth.auth()
  private let storage = Storage.storage()
  
  func fetchCurrentUser(successHandler: @escaping(UserRegistered) -> Void, errorHandler: @escaping(String) -> Void) {
    guard let userId = auth.currentUser?.uid else { return }
    let docRef = db.collection(UserConstant.users).document(userId)
    
    docRef.getDocument { document, error in
      if let error = error {
        return errorHandler(error.localizedDescription)
      }
      guard let document = document, document.exists else {
        return errorHandler("Impossible de trouver l'utilisateur")
      }
      if let user = try? document.data(as: UserRegistered.self) {
        return successHandler(user)
      }
    }
  }

  func createUser(userEmail: String, userPassword: String, completionHandler: @escaping(Bool, String?) -> Void) {

    auth.createUser(withEmail: userEmail, password: userPassword) { authResult, error in
      guard authResult != nil, error == nil else {
        let errorMessage = error?.localizedDescription ?? ""
        return completionHandler(false, errorMessage)
      }

      DispatchQueue.main.async {
        switch authResult {
        case .none:
          let errorMessage = error?.localizedDescription ?? ""
          return completionHandler(false, errorMessage)
        case .some(_):
          return completionHandler(true, nil)
        }
      }
    }
  }
  
  func saveProfileImage(image: UIImage, completionHandler: @escaping(Bool, String) -> Void) {
    guard let userId = auth.currentUser?.uid else { return }
    let ref = storage.reference(withPath: userId)
    
    guard let imageData = image.jpegData(compressionQuality: 0.5) else {
      return completionHandler(false, "Impossible de compresser l'image")
    }
    ref.putData(imageData, metadata: nil) { metadata, error in
      if let error = error {
        return completionHandler(false, error.localizedDescription)
      }
      
      ref.downloadURL { url, error in
          if let error = error {
            return completionHandler(false, error.localizedDescription)
        }
      guard let url = url else { return }
        return completionHandler(true, url.absoluteString)
      }
    }
  }
  
  func loginUser(userEmail: String, userPassword: String, completionHandler: @escaping(Bool, String?) -> Void) {

    auth.signIn(withEmail: userEmail, password: userPassword) { authResult, error in
      guard authResult != nil, error == nil else {
        let errorMessage = error?.localizedDescription ?? ""
        return completionHandler(false, errorMessage)
      }

      DispatchQueue.main.async {
        switch authResult {
        case .none:
          let errorMessage = error?.localizedDescription ?? ""
          return completionHandler(false, errorMessage)
        case .some(_):
          return completionHandler(true, nil)
        }
      }
    }
  }

  func googleLoginUser(completionHandler: @escaping(Bool, String) -> Void) {

    guard let clientID = FirebaseApp.app()?.options.clientID else { return }
    let config = GIDConfiguration(clientID: clientID)

    GIDSignIn.sharedInstance.signIn(with: config, presenting: LoginView().getRootViewController()) { user, error in
      if let error = error {
        return completionHandler(false, error.localizedDescription)
      }

      guard let authentication = user?.authentication,
            let idToken = authentication.idToken
      else {
        let errorMessage = error?.localizedDescription ?? ""
        return completionHandler(false, errorMessage)
      }

      let credential = GoogleAuthProvider.credential(withIDToken: idToken, accessToken: authentication.accessToken)

      self.auth.signIn(with: credential) { result, error in
        if let error = error {
          return completionHandler(false, error.localizedDescription)
        }

        guard let user = result?.user else {
          let errorMessage = error?.localizedDescription ?? ""
          return completionHandler(false, errorMessage)
        }
        
        return completionHandler(true, user.displayName ?? "")
      }
    }
  }

  func logoutUser(completionHandler: @escaping(Bool, String?) -> Void) {

    GIDSignIn.sharedInstance.signOut()

  do {
    try auth.signOut()
    return completionHandler(true, nil)
  } catch let signOutError as NSError {
      let errorMessage = signOutError.localizedDescription
      return completionHandler(false, errorMessage)
    }
  }

  func resetPassword(emailUser: String, completionHandler: @escaping(Bool, String?) -> Void) {
    auth.sendPasswordReset(withEmail: emailUser) { error in
      if let error = error {
        return completionHandler(false, error.localizedDescription)
      }
      return completionHandler(true, nil)
    }
  }

  func registrateUser(with user: UserDetailsForm, image: UIImage, completionHandler: @escaping(Bool, String?) -> Void) {

    guard let userId = auth.currentUser?.uid else { return }
    saveProfileImage(image: image) { result, url in
      if result {
  
        let userRegistered = UserRegistered(id: userId, name: user.name, surname: user.surname, pseudo: user.pseudo, profileImageUrl: url, email: user.email, phoneNumber: user.phoneNumber, discordPseudo: user.discordPseudo, street: user.street, zipCode: user.zipCode, city: user.city, isAdmin: false)
        
        try? self.db.collection(UserConstant.users).document(userId).setData(from: userRegistered) { error in
          if let error = error {
            return completionHandler(false, error.localizedDescription)
          }
          return completionHandler(true, nil)
        }
      } else {
       return completionHandler(false, url)
      }
    }
  }
}
