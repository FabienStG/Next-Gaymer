//
//  RegisterService.swift
//  Next Gaymer
//
//  Created by Fabien Saint Germain on 14/01/2022.
//

import UIKit
import Firebase
import FirebaseFirestoreSwift
import GoogleSignIn
//
// MARK: - Firebase User Services
//

/// This class manage all the calls used for manage users, from account creation, login, update and delete account
class FirebaseUserService {
  //
  // MARK: - Private Constants
  //
  private let db = Firestore.firestore()
  private let auth = Auth.auth()
  private let storage = Storage.storage()
  
  //
  // MARK: - Internal Methods
  //
  ///
  /// Account Creation
  ///
  ///This function create the user in the authentification app of firestore, with the email and the password provided
  func createUser(userEmail: String, userPassword: String, completionHandler: @escaping(Bool, String?) -> Void) {

    auth.createUser(withEmail: userEmail, password: userPassword) { authResult, error in
      guard authResult != nil, error == nil else {
        let errorMessage = error?.localizedDescription ?? NSLocalizedString("failCreateUser", comment: "")
        return completionHandler(false, errorMessage)
      }

      DispatchQueue.main.async {
        switch authResult {
        case .none:
          let errorMessage = error?.localizedDescription ?? NSLocalizedString("failCreateUser", comment: "")
          return completionHandler(false, errorMessage)
        case .some(_):
          return completionHandler(true, nil)
        }
      }
    }
  }
  
  /// With the choosen UIimage for the user profile, it saved it in the storage and return the url
  func saveProfileImage(image: UIImage, completionHandler: @escaping(Bool, String) -> Void) {
    guard let userId = auth.currentUser?.uid else { return }
    let ref = storage.reference(withPath: userId)
    
    guard let imageData = image.jpegData(compressionQuality: 0.5) else {
      return completionHandler(false, NSLocalizedString("failImageCompression", comment: ""))
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
  
  /// With the form provide by the user and the image, this function create the final userRegistered object saved into firestore
  func registrateUser(with user: UserForm, image: UIImage, completionHandler: @escaping(Bool, String?) -> Void) {

    guard let userId = auth.currentUser?.uid else { return }
    saveProfileImage(image: image) { result, url in
      if result {
  
        let userRegistered = UserRegistered(id: userId, name: user.name, surname: user.surname,
                                            pseudo: user.pseudo, profileImageUrl: url, email: user.email,
                                            phoneNumber: user.phoneNumber, discordPseudo: user.discordPseudo,
                                            street: user.street, zipCode: user.zipCode, city: user.city,
                                            isAdmin: false, myEvent: [])
        
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
  
  /// This function provide by the Google documentation manage the account with his own credentials
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
        let errorMessage = error?.localizedDescription ?? NSLocalizedString("failLogUser", comment: "")
        return completionHandler(false, errorMessage)
      }

      let credential = GoogleAuthProvider.credential(withIDToken: idToken, accessToken: authentication.accessToken)

      self.auth.signIn(with: credential) { result, error in
        if let error = error {
          return completionHandler(false, error.localizedDescription)
        }

        guard let user = result?.user else {
          let errorMessage = error?.localizedDescription ?? NSLocalizedString("failLogUser", comment: "")
          return completionHandler(false, errorMessage)
        }
        
        return completionHandler(true, user.displayName ?? "")
      }
    }
  }
  
  ///
  /// Login and logout
  ///
  ///This function log in the user
  func loginUser(userEmail: String, userPassword: String, completionHandler: @escaping(Bool, String?) -> Void) {

    auth.signIn(withEmail: userEmail, password: userPassword) { authResult, error in
      guard authResult != nil, error == nil else {
        let errorMessage = error?.localizedDescription ?? NSLocalizedString("failLogUser", comment: "")
        return completionHandler(false, errorMessage)
      }

      DispatchQueue.main.async {
        switch authResult {
        case .none:
          let errorMessage = error?.localizedDescription ?? NSLocalizedString("failLogUser", comment: "")
          return completionHandler(false, errorMessage)
        case .some(_):
          return completionHandler(true, nil)
        }
      }
    }
  }

  /// It log out the user and signOut for Google if he use it
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

  ///
  /// Account management
  ///
  ///This is one of the most important and used function, who return the current user profile use by the app
  func fetchCurrentUser(successHandler: @escaping(UserRegistered) -> Void, errorHandler: @escaping(String) -> Void) {
    guard let userId = auth.currentUser?.uid else { return }
    let docRef = db.collection(UserConstant.users).document(userId)
    
    docRef.getDocument { document, error in
      if let error = error {
        return errorHandler(error.localizedDescription)
      }
      guard let document = document, document.exists else {
        return errorHandler(NSLocalizedString("failFindUser", comment: ""))
      }
      if let user = try? document.data(as: UserRegistered.self) {
        return successHandler(user)
      }
    }
  }
  
  /// TO IMPLEMENT
  /// This function delete all the current user info stored in the firestore and the storage.
  func deleteCurrentUser(completionHandler: @escaping(Bool, String?) -> Void) {
    
    guard let user = auth.currentUser else { return }
    db.collection(UserConstant.users).document(user.uid).delete() { error in
      if let error = error {
        return completionHandler(false, error.localizedDescription)
      }
    }
    storage.reference(withPath: user.uid).delete { error in
      if let error = error {
        return completionHandler(false, error.localizedDescription)
      }
    }
    user.delete { error in
      if let error = error {
        return completionHandler(false, error.localizedDescription)
      }
    }
    return completionHandler(true, nil)
  }
  
  /// TO IMPLEMENT
  /// This function update the user info stored in firebase with the user modifications
  func updateUserInfo(userInfo: [String: Any], completionHandler: @escaping(Bool, String) -> Void) {
    
    guard let userId = auth.currentUser?.uid else { return }
    let userRef = db.collection(UserConstant.users).document(userId)
    
    userRef.updateData(userInfo) { error in
      if let error = error {
        return completionHandler(false, error.localizedDescription)
      } else {
        return completionHandler(true, NSLocalizedString("modificationComplete", comment: ""))
      }
    }
  }
}
