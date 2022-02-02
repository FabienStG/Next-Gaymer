//
//  ChatLogViewModel.swift
//  Next Gaymer
//
//  Created by Fabien Saint Germain on 22/01/2022.
//

import SwiftUI
import Firebase

class ChatLogAdminViewModel: ObservableObject {
  
  @Published var chatText = ""
  @Published var chatMessages = [ChatMessage]()
  
  @Published var errorMessage = ""
  @Published var showAlert = false
  
  @Published var selectedUser: UserRegistered?

  func fetchMessages(senderUser: UserRegistered, recipientUser: UserDetails) {
    chatMessages.removeAll()
    DataManager.shared.chatMessageListener(senderUser: senderUser, recipientUser: recipientUser, listen: self)
  }
  
  func saveMessage(senderUser: UserRegistered, recipientUser: UserDetails) {
        
    DataManager.shared.saveMessage(textMessage: chatText, senderUser: senderUser, recipientUser: recipientUser) { response, error in
      if !response {
        self.errorMessage = error ?? ""
        self.showAlert.toggle()
      } else {
        self.chatText = ""
      }
    }
  }
  
  func disableButton() -> Bool {
    return chatText.isEmpty
  }
}

extension ChatLogAdminViewModel: Listener {
  
  func haveChatMessage(_ message: ChatMessage) {
    chatMessages.append(message)
  }
  
  func haveRecentMessage(_ message: RecentMessage) {}
  
  func haveError(_ errorMessage: String) {
    self.errorMessage = errorMessage
    showAlert.toggle()
  }
  
  func stopListening() {
    DataManager.shared.stopChatListening()
  }
  
}
