//
//  FirebaseChatServices.swift
//  Next Gaymer
//
//  Created by Fabien Saint Germain on 22/01/2022.
//

import Foundation
import Firebase
//
// MARK: - Firebase Chat Services
//

/// This class manage the calls related to the live chat function
class FirebaseChatServices: ChatServices {
  //
  // MARK: - Private Constant
  //
  private let auth = Auth.auth()
  private let db = Firestore.firestore()
  private var firebaseChatListener: ListenerRegistration?
  private var firebaseRecentMessageListener: ListenerRegistration?
  
  //
  // MARK: - Internal Methods
  //
  /// Remove the firebase listener to stop the automatic query from the live chat page
  func stopChatListening() {
    firebaseChatListener?.remove()
  }
  
  /// Remove the firebase listener to stop the automatic query from the recent message page
  func stopRecentMessageListening() {
    firebaseRecentMessageListener?.remove()
  }
  
  /// Fetch a user with his Id and return the document as an object
  func fetchSpecificUser(selectedUser: String, completionHandler: @escaping(UserRegistered?, String?) -> Void) {
    
    db.collection(UserConstant.users).document(selectedUser).getDocument { document, error in
      if let error = error {
        return completionHandler(nil, error.localizedDescription)
      }
      
      guard let document = document, document.exists else {
        return completionHandler(nil, NSLocalizedString("failFindUser", comment: ""))
      }
      
      if let user = try? document.data(as: UserRegistered.self) {
        return completionHandler(user, nil)
      }
    }
  }
  
  /// Fetch the messages registered in firestore and put a firestore listener to update automaticly when any message is send, throught the protocol
  func fetchMessages(senderUser: UserRegistered, recipientUser: UserDetails, listen: Listener) {
    
    firebaseChatListener = db
      .collection(MessageConstant.messages)
      .document(senderUser.id)
      .collection(recipientUser.id)
      .order(by: MessageConstant.timestamp)
      .addSnapshotListener { querySnapshop, error in
        if let error = error {
          listen.haveError(error.localizedDescription)
          return
        }
        
        querySnapshop?.documentChanges.forEach { change in
          if change.type == .added {
            if let message = try? change.document.data(as: ChatMessage.self) {
              listen.haveChatMessage(message)
            } else {
              listen.haveError(error?.localizedDescription ?? NSLocalizedString("failFetchMessage", comment: ""))
            }
          }
        }
      }
  }
  
  /// Fetch all the recents messages sent for the main message page, and put a firestore listener to update automaticly when any message is send, throught the protocol
  func fetchRecentMessages(listen: Listener) {
    
    guard let currentUserId = auth.currentUser?.uid else { return }
    
    firebaseRecentMessageListener = db
      .collection(MessageConstant.recentMessages)
      .document(currentUserId)
      .collection(MessageConstant.messages)
      .order(by: MessageConstant.timestamp)
      .addSnapshotListener({ querySnapshot, error in
        if let error = error {
          listen.haveError(error.localizedDescription)
          return
        }
        
        querySnapshot?.documentChanges.forEach({ change in
          if let recentMessage = try? change.document.data(as: RecentMessage.self) {
            listen.haveRecentMessage(recentMessage)
          } else {
            listen.haveError(error?.localizedDescription ?? NSLocalizedString("failFetchMessage", comment: ""))
          }
        })
      })
  }
  
  /// Save a message as a chat message in firestore in two versions, one for the sender, one for the recipient
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
  
  /// Save a message as a recent message object in firestore in two versions, one for the sender and one for the recipient
  func saveRecentMessage(textMessage: String, senderUser: UserRegistered, recipientUser: UserDetails, completionHandler: @escaping(Bool, String?) -> Void) {
    
    guard let senderUserId = auth.currentUser?.uid else { return }
    let document = db.collection(MessageConstant.recentMessages)
      .document(senderUserId)
      .collection(MessageConstant.messages)
      .document(recipientUser.id)
    
    let message = RecentMessage(id: nil, text: textMessage, senderUserId: senderUserId, recipientUserId:
                                  recipientUser.id, timestamp: Date(), profileImageUrl: recipientUser.profileImageUrl,
                                pseudo: recipientUser.pseudo, isAdmin: recipientUser.isAdmin)
    try? document.setData(from: message) { error in
      if let error = error {
        return completionHandler(false, error.localizedDescription)
      }
    }
    let recipientCopyDocument = db.collection(MessageConstant.recentMessages)
      .document(recipientUser.id)
      .collection(MessageConstant.messages)
      .document(senderUserId)
    
    let recipientCopyMessage = RecentMessage(id: nil, text: textMessage, senderUserId: senderUserId,
                                             recipientUserId: recipientUser.id, timestamp: Date(), profileImageUrl: senderUser.profileImageUrl,
                                             pseudo: senderUser.pseudo, isAdmin: senderUser.isAdmin)
    try? recipientCopyDocument.setData(from: recipientCopyMessage) { error in
      return completionHandler(false, error?.localizedDescription)
    }
    return completionHandler(true, nil)
  }
  
  /// Delete the recent message
  func deleteRecentMessage(message: RecentMessage) {
    
    guard let userId = auth.currentUser?.uid else { return }
    let document = db.collection(MessageConstant.recentMessages).document(userId).collection(MessageConstant.messages).document(message.id!)
    
    document.delete() 
  }
}
