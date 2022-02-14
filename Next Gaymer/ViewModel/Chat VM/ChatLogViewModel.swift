//
//  ChatLogViewModel.swift
//  Next Gaymer
//
//  Created by Fabien Saint Germain on 22/01/2022.
//

import SwiftUI
//
// MARK: - Chat Log VM
//

/// This class show the messages in the ChatLogview
class ChatLogViewModel: ObservableObject {
  //
  // MARK: - Published Properties
  //
  @Published var chatText = ""
  @Published var chatMessages = [ChatMessage]()
  
  @Published var errorMessage = ""
  @Published var showAlert = false
  
  @Published var selectedUser: UserRegistered?

  //
  // MARK: - Internal Methods
  //
  /// Disable the send button is the chat text is empty
  func disableButton() -> Bool {
    return chatText.isEmpty
  }
  
  /// This function call the DataManager to fetch all the messages and add the listener to be aware of all updates
  func fetchMessages(senderUser: UserRegistered, recipientUser: UserDetails) {
    chatMessages.removeAll()
    DataManager.shared().chatMessageListener(senderUser: senderUser, recipientUser: recipientUser, listen: self)
  }
  
  /// Save the sended message and show if is any error
  func saveMessage(senderUser: UserRegistered, recipientUser: UserDetails) {
        
    DataManager.shared().saveMessage(textMessage: chatText, senderUser: senderUser, recipientUser: recipientUser) { response, error in
      if !response {
        self.errorMessage = error ?? ""
        self.showAlert.toggle()
      } else {
        self.chatText = ""
      }
    }
  }
}

//
// MARK: - Extension Chat Log VM - Listener Protocol
//

/// This extension give the Listener protocol the the view model, this protocol is used to be notified by any message update
extension ChatLogViewModel: Listener {
  //
  // MARK: - Internal Methods
  //
  ///Protocol function who add the update message in the array showed in the view
  func haveChatMessage(_ message: ChatMessage) {
    chatMessages.append(message)
  }
  
  /// Function who catch the errorMessage if there is one during the message update
  func haveError(_ errorMessage: String) {
    self.errorMessage = errorMessage
    showAlert.toggle()
  }
  
  /// Function who ask to stop listening the update when the view close
  func stopListening() {
    DataManager.shared().stopChatListening()
  }
  
  /// Function from the protocol but not used by this VM
  func haveRecentMessage(_ message: RecentMessage) {}
}
