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
  let db = Firestore.firestore()
  
  func fetchAllUsers(successHandler: @escaping ([UserRegistered]) -> Void, errorHandler: @escaping(String) -> Void) {
    
    var usersResponse = [UserRegistered]()
    
    db.collection(UserConstant.users).getDocuments { documentsSnapshot, error in
      if let error = error {
        return errorHandler(error.localizedDescription)
      }
      
      documentsSnapshot?.documents.forEach({ document in
        guard let user = try? document.data(as: UserRegistered.self) else {
          return errorHandler("Impossible de récupérer la liste des utilisateur")
        }
        if user.id != self.auth.currentUser?.uid {
          usersResponse.append(user)
        }
      })
      return successHandler(usersResponse)
    }
  }
}
