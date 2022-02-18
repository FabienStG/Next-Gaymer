//
//  MainMessagesAdminViewModel.swift
//  Next Gaymer
//
//  Created by Fabien Saint Germain on 24/01/2022.
//

import SwiftUI
//
// MARK: - Main Message VM
//

/// This class give to the view the recent messages returned by the data manager, give the selected user for the next view and allowed or not the
/// view change.
class MainMessageViewModel: ObservableObject {
  //
  // MARK: - Published Properties
  //
  @Published var recentMessages = [RecentMessage]()

  @Published var errorMessage = ""
  @Published var showAlert = false
  
  @Published var selectedUser: UserDetails?
  @Published var isShowingLogchat = false
  
  //
  // MARK: - Internal Methods
  //
  /// This function fetch the recent messages with the data manager and add the listener to be notified by any update
  func fetchRecentMessages(currentUser: UserRegistered) {
    DataManager.shared().recentMessageListener(currentUser: currentUser, listen: self)
  }
  
  /// This function take the id saved in the RecentMessage object, and return the selected user used by the chatlog view
  func fetchSelectedUser(currentUser: UserRegistered, messageSelected: RecentMessage) {
    DataManager.shared().fetchSpecificUser(selectedUser: selectUserId(currentUser: currentUser, messageSelected: messageSelected)) { user, error in
      if let user = user {
        self.selectedUser = user
        self.isShowingLogchat = true
      } else {
        self.errorMessage = error ?? NSLocalizedString("failFindUser", comment: "")
        self.showAlert.toggle()
      }
    }
  }
  
  //
  // MARK: - Private Method
  //
  /// This private function compare Id to always return as a selected user no the current one
  private func selectUserId(currentUser: UserRegistered, messageSelected: RecentMessage) -> String {
    
    let currentUserId = currentUser.id
    let senderId = messageSelected.senderUserId
    let recipientId = messageSelected.recipientUserId
    
    return currentUserId == senderId ? recipientId : senderId
  }
}

//
// MARK: - Extension Main Message VM - Listener Protocol
//

/// This extension give to the view model the listener protocol
extension MainMessageViewModel: Listener {
  //
  // MARK: - Internal Methods
  //
  /// This fonction is from the protocol and not used by this view model
  func haveChatMessage(_ message: ChatMessage) {}
  
  /// This function recieve any new recent message, and check in his own array where he have to be update
  func haveRecentMessage(_ message: RecentMessage) {
    let docId = message.id
    if let index = self.recentMessages.firstIndex(where: { recentMessage in
      return recentMessage.id == docId
    }) {
      self.recentMessages.remove(at: index)
    }
    self.recentMessages.insert(message, at: 0)
  }
  
  /// This function catch the error message during the update process
  func haveError(_ errorMessage: String) {
    self.errorMessage = errorMessage
    showAlert.toggle()
  }
  
  /// This function remove the listener
  func stopListening() {
    DataManager.shared().stopRecentMessageListening()
  }
}
