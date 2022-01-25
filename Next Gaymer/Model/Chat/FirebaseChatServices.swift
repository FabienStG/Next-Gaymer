//
//  FirebaseChatServices.swift
//  Next Gaymer
//
//  Created by Fabien Saint Germain on 22/01/2022.
//

import Foundation
import Firebase

class FirebaseChatServices {
  
  private let auth = Auth.auth()
  private let db = Firestore.firestore()

  func saveMessage(textMessage: String, recipientUserId: String, completionHandler: @escaping(Bool, String?) -> Void) {
    
    guard let senderUserId = auth.currentUser?.uid else { return }
    
    let document = db.collection(MessageConstant.messages)
      .document(senderUserId)
      .collection(recipientUserId)
      .document()
    
    let message = ChatMessage(id: nil, senderUserId: senderUserId, recipientUserId: recipientUserId, text: textMessage, timestamp: Date())
    
    try? document.setData(from: message) { error in
      if let error = error {
        return completionHandler(false, error.localizedDescription)
      }
    }
    
    let recipientCopyMessage = db.collection(MessageConstant.messages)
      .document(recipientUserId)
      .collection(senderUserId)
      .document()
    
    try? recipientCopyMessage.setData(from: message) { error in
      return completionHandler(false, error?.localizedDescription)
    }
    
    return completionHandler(true, nil)
    
  }
  
  func saveRecentMessage(textMessage: String, senderUser: UserRegistered, recipientUser: UserDetailsAdmin, completionHandler: @escaping(Bool, String?) -> Void) {
    
    guard let senderUserId = auth.currentUser?.uid else { return }
    
    let document = db.collection(MessageConstant.recentMessages)
      .document(senderUserId)
      .collection(MessageConstant.messages)
      .document(recipientUser.id)
    
    let message = RecentMessage(id: nil, text: textMessage, senderUserId: senderUserId, recipientUserId: recipientUser.id, timestamp: Date(), profileImageUrl: recipientUser.profileImageUrl, pseudo: recipientUser.pseudo, isAdmin: recipientUser.isAdmin)
    
    try? document.setData(from: message) { error in
      if let error = error {
        return completionHandler(false, error.localizedDescription)
      }
    }
    
    let recipientCopyDocument = db.collection(MessageConstant.recentMessages)
      .document(recipientUser.id)
      .collection(MessageConstant.messages)
      .document(senderUserId)
    
    let recipientCopyMessage = RecentMessage(id: nil, text: textMessage, senderUserId: senderUserId, recipientUserId: recipientUser.id, timestamp: Date(), profileImageUrl: senderUser.profileImageUrl, pseudo: senderUser.pseudo, isAdmin: senderUser.isAdmin)
    
    try? recipientCopyDocument.setData(from: recipientCopyMessage) { error in
      return completionHandler(false, error?.localizedDescription)
    }
    
    return completionHandler(true, nil)
  }
  
  func fetchSpecificUser(selectedUser: String, completionHandler: @escaping(UserRegistered?, String?) -> Void) {
    
    db.collection(UserConstant.users).document(selectedUser).getDocument { document, error in
      if let error = error {
        return completionHandler(nil, error.localizedDescription)
      }
      
      guard let document = document, document.exists else {
        return completionHandler(nil, "Impossible de retrouver l'utilisateur")
      }
      
      if let user = try? document.data(as: UserRegistered.self) {
        return completionHandler(user, nil)
      }
    }
  }
}
