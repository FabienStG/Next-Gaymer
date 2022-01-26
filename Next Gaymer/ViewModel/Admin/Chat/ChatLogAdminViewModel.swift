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

  var firestoreListener: ListenerRegistration?

  func fetchMessages(senderUser: UserRegistered, recipientUser: UserDetailsAdmin) {
    chatMessages.removeAll()

    firestoreListener = DataManager.shared.firebaseAdminService.db
      .collection(MessageConstant.messages)
      .document(senderUser.id)
      .collection(recipientUser.id)
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
  
  
  func saveMessage(senderUser: UserRegistered, recipientUser: UserDetailsAdmin) {
        
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

/// Protocole : deux fonctions = un qui dit qu'il y a un message, l'autre une erreur
/// Remettre le bloc au service, avec comme paramètre le protocole  et au data manager
///

protocol MessageListener: AnyObject {
  
  func newMessageArrived(newMessage: ChatMessage)
  func errorInFetching(errorMessage: String)
  func startListening()
  func stopListening()
  
}
