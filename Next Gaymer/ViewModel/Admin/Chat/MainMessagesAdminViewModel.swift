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
  
  var firestoreListener: ListenerRegistration?

  func fetchRecentMessages(currentUser: UserRegistered) {
    print("Fetching Recent Messages")
        
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
}
