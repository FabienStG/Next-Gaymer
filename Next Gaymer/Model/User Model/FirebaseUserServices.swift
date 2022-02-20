//
//  FirebaseUserServices.swift
//  Next Gaymer
//
//  Created by Fabien Saint Germain on 07/02/2022.
//

import Foundation
import Firebase
//
// MARK: - Firebase User Services
//

/// This struct manage the user account once is created
class FirebaseUserServices: UserServices {  
  //
  // MARK: - Private Properties
  //
  private let auth = Auth.auth()
  private let db = Firestore.firestore()
  private let storage = Storage.storage()
  
  //
  // MARK: - Internal Methods
  //
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
  
  /// This function fetch the users and return the admin
  func fetchAllAdmin(successHandler: @escaping ([UserRegistered]) -> Void, errorHandler: @escaping(String) -> Void) {
    
    var usersResponse = [UserRegistered]()
    db.collection(UserConstant.users).getDocuments { documentsSnapshot, error in
      if let error = error {
        return errorHandler(error.localizedDescription)
      }
      
      documentsSnapshot?.documents.forEach({ document in
        guard let user = try? document.data(as: UserRegistered.self) else {
          return errorHandler(NSLocalizedString("failFetchUserList", comment: ""))
        }
        if user.isAdmin {
          usersResponse.append(user)
        }
      })
      return successHandler(usersResponse)
    }
  }
  
  /// This function delete all the current user info stored in the firestore and the storage.
  func deleteCurrentUser(completionHandler: @escaping(Bool, String?) -> Void) {
    
    guard let user = auth.currentUser else { return }
    
    db.collection(UserConstant.users).document(user.uid).delete()
    db.collection(EventConstant.eventReminder).document(user.uid).delete()
    storage.reference(withPath: user.uid).delete()
    
    user.delete() { error in
      if let error = error {
        return completionHandler(false, error.localizedDescription)
      }
    }
    return completionHandler(true, nil)
  }
  
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
  
  /// This function reauthenticate the user for specific action like update password or delete profile
  func reauthenticateUser(email: String, password: String, completionHandler: @escaping(Bool, String?) -> Void) {
    
    let user = auth.currentUser
    let credential = EmailAuthProvider.credential(withEmail: email, password: password)
    
    user?.reauthenticate(with: credential) { result, error in
      if let error = error {
        return completionHandler(false, error.localizedDescription)
      }
      return completionHandler(true, nil)
    }
  }
}
