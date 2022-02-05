//
//  ChatLogView.swift
//  Next Gaymer
//
//  Created by Fabien Saint Germain on 23/01/2022.
//

import SwiftUI

struct ChatLogView: View {
  
  @StateObject var chatLogModel = ChatLogViewModel()
  @StateObject var selectedUser: SelectedUserViewModel
  @EnvironmentObject var currentUser: CurrentUserViewModel
  
  var body: some View {
    VStack {
      ScrollView {
        VStack {
          ForEach(chatLogModel.chatMessages) { message in
            MessageView(message: message, currentUserId: currentUser.currentUser!.id)
          }
        }
      }
    }
    .safeAreaInset(edge: .bottom) {
      HStack {
        TextField("Message", text: $chatLogModel.chatText)
          .padding()
        Spacer()
        Button {
          chatLogModel.saveMessage(senderUser: currentUser.currentUser!,
                                        recipientUser: selectedUser.selectedUser)
        } label: {
          Text(NSLocalizedString("send", comment: ""))
            .foregroundColor(Color.blue)
            .padding()
        }
        .disabled(chatLogModel.disableButton())
      }
    }
    .onDisappear(perform: {
      chatLogModel.stopListening()
    })
    .onAppear {
      chatLogModel.fetchMessages(senderUser: currentUser.currentUser!,
                                      recipientUser: selectedUser.selectedUser)
    }
  }
}

struct ChatLogView_Previews: PreviewProvider {
  
  static var previews: some View {
    NavigationView {
      ChatLogView(selectedUser: FakePreviewData.selectedUser)
        .environmentObject(FakePreviewData.currentAdminUser)
    }
  }
}
