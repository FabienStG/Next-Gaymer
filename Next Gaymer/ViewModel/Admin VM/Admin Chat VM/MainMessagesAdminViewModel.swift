//
//  MainMessagesAdminViewModel.swift
//  Next Gaymer
//
//  Created by Fabien Saint Germain on 24/01/2022.
//

import SwiftUI

class MainMessageAdminViewModel: ObservableObject {
  
  @Published var recentMessages = [RecentMessage]()

  @Published var errorMessage = ""
  @Published var showAlert = false
  
  @Published var selectedUser: UserDetails?
  @Published var isShowingLogchat = false
  
  func fetchRecentMessages(currentUser: UserRegistered) {
    DataManager.shared.recentMessageListener(currentUser: currentUser, listen: self)
  }
  
  func fetchSelectedUser(currentUser: UserRegistered, messageSelected: RecentMessage) {
    DataManager.shared.fetchSpecificUser(selectedUser: selectUserId(currentUser: currentUser, messageSelected: messageSelected)) { user, error in
      if let user = user {
        self.selectedUser = user
        self.isShowingLogchat = true
      } else {
        self.errorMessage = error ?? NSLocalizedString("failFindUser", comment: "")
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

extension MainMessageAdminViewModel: Listener {
  
  func haveChatMessage(_ message: ChatMessage) {}
  
  func haveRecentMessage(_ message: RecentMessage) {
    let docId = message.id
    if let index = self.recentMessages.firstIndex(where: { recentMessage in
      return recentMessage.id == docId
    }) {
      self.recentMessages.remove(at: index)
    }
    self.recentMessages.insert(message, at: 0)
  }
  
  func haveError(_ errorMessage: String) {
    self.errorMessage = errorMessage
    showAlert.toggle()
  }
  
  func stopListening() {
    DataManager.shared.stopRecentMessageListening()
  }
}
