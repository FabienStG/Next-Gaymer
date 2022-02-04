//
//  ChatLogView.swift
//  Next Gaymer
//
//  Created by Fabien Saint Germain on 23/01/2022.
//

import SwiftUI

struct ChatLogAdminView: View {
  
  @StateObject var chatLogAdminModel = ChatLogAdminViewModel()
  @StateObject var selectedUser: SelectedUserViewModel
  @EnvironmentObject var currentUser: CurrentUserViewModel
  
  var body: some View {
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
      HStack {
        TextField("Message", text: $chatLogAdminModel.chatText)
          .padding()
        Spacer()
        Button {
          chatLogAdminModel.saveMessage(senderUser: currentUser.currentUser!,
                                        recipientUser: selectedUser.selectedUser)
        } label: {
          Text(NSLocalizedString("send", comment: ""))
            .foregroundColor(Color.blue)
            .padding()
        }
        .disabled(chatLogAdminModel.disableButton())
      }
    }
    .onDisappear(perform: {
      chatLogAdminModel.stopListening()
    })
    .onAppear {
      chatLogAdminModel.fetchMessages(senderUser: currentUser.currentUser!,
                                      recipientUser: selectedUser.selectedUser)
    }
  }
}

struct ChatLogViewAdmin_Previews: PreviewProvider {
  
  static var previews: some View {
    NavigationView {
      ChatLogAdminView(selectedUser: FakePreviewData.selectedUser)
        .environmentObject(FakePreviewData.currentAdminUser)
    }
  }
}
