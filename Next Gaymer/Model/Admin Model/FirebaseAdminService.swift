//
//  FirebaseChatService.swift
//  Next Gaymer
//
//  Created by Fabien Saint Germain on 21/01/2022.
//

import Firebase
import FirebaseFirestoreSwift
import Foundation

class FirebaseAdminService {
  
  private let auth = Auth.auth()
  private let db = Firestore.firestore()
  
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
  
  func fetchEventRegistrants(event: EventCreated, completionHandler: @escaping(Bool, String) -> Void) {
    
  }
}
