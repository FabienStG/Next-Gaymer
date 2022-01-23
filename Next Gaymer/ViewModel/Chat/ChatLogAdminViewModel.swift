//
//  ChatLogViewModel.swift
//  Next Gaymer
//
//  Created by Fabien Saint Germain on 22/01/2022.
//

import SwiftUI
import Firebase

class ChatLogViewModel: ObservableObject {
  
  @EnvironmentObject var currentUserModel: CurrentUserViewModel
  @EnvironmentObject var usersAdminModel: UsersAdminViewModel
  
  @Published var chatText = ""
  @Published var chatMessages = [ChatMessage]()
  
  @Published var errorMessage = ""
  @Published var showAlert = false
  @Published var count = 0
  
  var firestoreListener: ListenerRegistration?
  
  init() {
    fetchMessages()
  }
  
  func fetchMessages() {
    print("Fetching Messages")
    guard let senderId = currentUserModel.currentUser?.id else { return }
    guard let recipentId = usersAdminModel.selectedUser?.id else { return }
    
    firestoreListener?.remove()
    chatMessages.removeAll()
    
    firestoreListener = DataManager.shared.firebaseAdminService.db
      .collection(MessageConstant.messages)
      .document(senderId)
      .collection(recipentId)
      .order(by: MessageConstant.timestamp)
      .addSnapshotListener { querySnapshop, error in
        if let error = error {
          self.errorMessage = error.localizedDescription
          return
        }
        
        querySnapshop?.documentChanges.forEach { change in
          if change.type == .added {
            if let message = try? change.document.data(as: ChatMessage.self) {
              self.chatMessages.append(message)
            } else {
              self.errorMessage = "Impossible de récupérer les messages"
            }
          }
        }
      }
  }
  
  func saveMessage() {
    
    guard let currentUser = currentUserModel.currentUser else { return }
    guard let recipientUser = usersAdminModel.selectedUser else { return }
    
    DataManager.shared.saveMessage(textMessage: chatText, senderUser: currentUser, recipientUser: recipientUser) { response, error in
      if !response {
        self.errorMessage = error ?? ""
        self.showAlert.toggle()
      }
    }
  }
}
