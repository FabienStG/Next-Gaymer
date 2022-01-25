//
//  MainMessagesAdminViewModel.swift
//  Next Gaymer
//
//  Created by Fabien Saint Germain on 24/01/2022.
//

import SwiftUI
import Firebase

class MainMessageAdminViewModel: ObservableObject {
  
  @Published var errorMessage = ""
  @Published var recentMessages = [RecentMessage]()
  @Published var isShowingLogchat = false
  
  @Published var selectedUser: UserDetailsAdmin?
  
  var firestoreListener: ListenerRegistration?

  func fetchRecentMessages(currentUser: UserRegistered) {
    firestoreListener?.remove()
    recentMessages.removeAll()
    
    firestoreListener = DataManager.shared.firebaseAdminService.db
      .collection(MessageConstant.recentMessages)
      .document(currentUser.id)
      .collection(MessageConstant.messages)
      .order(by: MessageConstant.timestamp)
      .addSnapshotListener({ querySnapshot, error in
        if let error = error {
          self.errorMessage = error.localizedDescription
          return
        }
        
        querySnapshot?.documentChanges.forEach({ change in
          let docId = change.document.documentID
          
          if let index = self.recentMessages.firstIndex(where: { recentMessage in
            return recentMessage.id == docId
          }) {
            self.recentMessages.remove(at: index)
          }
          
          if let recentMessage = try? change.document.data(as: RecentMessage.self) {
            self.recentMessages.insert(recentMessage, at: 0)
          } else {
            self.errorMessage = "Impossible de récupérer l'historique des messages"
          }
        })
      })
  }
  
  func fetchSelectedUser(currentUser: UserRegistered, messageSelected: RecentMessage) {
    DataManager.shared.fetchSpecificUser(selectedUser: selectUserId(currentUser: currentUser, messageSelected: messageSelected)) { user, error in
      if let user = user {
        self.selectedUser = user
        self.isShowingLogchat = true
      } else {
        self.errorMessage = error ?? "Impossible de récupérer l'utilisateur"
      }
    }
  }
  
  private func selectUserId(currentUser: UserRegistered, messageSelected: RecentMessage) -> String {
    
    let currentUserId = currentUser.id
    let senderId = messageSelected.senderUserId
    let recipientId = messageSelected.recipientUserId
    
    return currentUserId == senderId ? recipientId : senderId
  }
}
