//
//  FirebaseChatService.swift
//  Next Gaymer
//
//  Created by Fabien Saint Germain on 21/01/2022.
//

import Firebase
import FirebaseFirestoreSwift
import Foundation
//
// MARK: - Firebase Admin Services
//

/// This class provide all the calls used for the admin' only function
class FirebaseAdminService {
  //
  // MARK: - Private Constant
  //
  private let auth = Auth.auth()
  private let db = Firestore.firestore()
  
  //
  // MARK: - Internal Methods
  //
  func setUserAdminCredentials(userId: String, completionHandler: @escaping(String) -> Void) {
    
    let userRef = db.collection(UserConstant.users).document(userId)
    userRef.updateData([
      "isAdmin": true]) { error in
        if let error = error {
          return completionHandler(error.localizedDescription)
        } else {
          return completionHandler(NSLocalizedString("modificationComplete", comment: ""))
        }
      }
  }
  
  func fetchAllUsers(successHandler: @escaping ([UserRegistered]) -> Void, errorHandler: @escaping(String) -> Void) {
    
    var usersResponse = [UserRegistered]()
    db.collection(UserConstant.users).getDocuments { documentsSnapshot, error in
      if let error = error {
        return errorHandler(error.localizedDescription)
      }
      
      documentsSnapshot?.documents.forEach({ document in
        guard let user = try? document.data(as: UserRegistered.self) else {
          return errorHandler(NSLocalizedString("failFetchUserList", comment: ""))
        }
        if user.id != self.auth.currentUser?.uid {
          usersResponse.append(user)
        }
      })
      return successHandler(usersResponse)
    }
  }
  

  ///
  ///
  /// A COMPLETER FONCTIONS DE  RECUPERATION UTILISATEURS
  ///

  
  func fetchEventRegistrants(event: EventCreated, completionHandler: @escaping(Bool, String) -> Void) {
    
  }
}
