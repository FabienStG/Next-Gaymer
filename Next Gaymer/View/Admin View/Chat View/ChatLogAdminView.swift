//
//  ChatLogView.swift
//  Next Gaymer
//
//  Created by Fabien Saint Germain on 23/01/2022.
//

import SwiftUI

struct ChatLogAdminView: View {
  
  @StateObject var chatLogAdminModel = ChatLogAdminViewModel()
  @EnvironmentObject var currentUser: CurrentUserViewModel
  @EnvironmentObject var selectedUser: UserDetailsAdminViewModel
  
    var body: some View {
      NavigationView {
        VStack {
          ScrollView {
              VStack {
                ForEach(chatLogAdminModel.chatMessages) { message in
                  MessageView(message: message, currentUserId: currentUser.currentUser!.id)
                }
              }
            }
          }
          .safeAreaInset(edge: .bottom) {
            TextField("Message", text: $chatLogAdminModel.chatText)
            Button("Envoyer") {
              chatLogAdminModel.saveMessage(senderUser: currentUser.currentUser!, recipientUser: selectedUser.selectedUser)
            }
            .disabled(chatLogAdminModel.disableButton())
          }
      }
      .onDisappear(perform: {
        chatLogAdminModel.firestoreListener?.remove()
      })
      .onAppear {
       chatLogAdminModel.fetchMessages(senderUser: currentUser.currentUser!, recipientUser: selectedUser.selectedUser)
      }
    }
}

/*  struct ChatLogView_Previews: PreviewProvider {
  
    static var previews: some View {
      ChatLogAdminView()
    }
}*/
  
