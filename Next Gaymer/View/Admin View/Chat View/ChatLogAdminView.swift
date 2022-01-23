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
      ZStack {
        VStack {
          ScrollView {
            ScrollViewReader { scrollViewProxy in
              VStack {
                ForEach(chatLogAdminModel.chatMessages) { message in
                  MessageView(message: message, currentUserId: currentUser.currentUser!.id)
                }
                
                HStack {
                  Spacer()
                }
                .id("Empty")
              }
              .onReceive(chatLogAdminModel.$count) { _ in
                withAnimation(.easeOut(duration: 0.5)) {
                  scrollViewProxy.scrollTo("empty", anchor: .bottom)
                }
              }
            }
          }
          .safeAreaInset(edge: .bottom) {
            TextField("Message", text: $chatLogAdminModel.chatText)
            Button("Envoyer") {
              chatLogAdminModel.saveMessage(senderUser: currentUser.currentUser!, recipientUser: selectedUser.selectedUser)
            }
          }
        }
      }
      }
      .onDisappear(perform: {
        chatLogAdminModel.firestoreListener?.remove()
        print("removed")
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
  
