//
//  ChatLogView.swift
//  Next Gaymer
//
//  Created by Fabien Saint Germain on 23/01/2022.
//

import SwiftUI

struct ChatLogView: View {
  
  @StateObject var chatLogModel = ChatLogViewModel()
  @EnvironmentObject var currentUser: CurrentUserViewModel
  @EnvironmentObject var selectedUser: UsersAdminViewModel
  
    var body: some View {
      ZStack {
        VStack {
          ScrollView {
            ScrollViewReader { scrollViewProxy in
              VStack {
                ForEach(chatLogModel.chatMessages) { message in
                  MessageView(message: message, currentUserId: currentUser.currentUser!.id)
                }
                
                HStack {
                  Spacer()
                }
                .id("Empty")
              }
              .onReceive(chatLogModel.$count) { _ in
                withAnimation(.easeOut(duration: 0.5)) {
                  scrollViewProxy.scrollTo("empty", anchor: .bottom)
                }
              }
            }
          }
          .safeAreaInset(edge: .bottom) {
            Button("Envoyer") {
              chatLogModel.saveMessage()
            }
          }
        }
      }
     
    }
}

/*struct ChatLogView_Previews: PreviewProvider {
  
    static var previews: some View {
      /*ChatLogView().environmentObject(FakeCurrentUserViewModel(currentUser: .init(id: "Fake", name: "Fake", surname: "", pseudo: "", profileImageUrl: "", email: "", phoneNumber: "", discordPseudo: "", street: "", zipCode: "", city: "", isAdmin: true))).environmentObject(UsersAdminViewModel())*/
      ChatLogView().environmentObject(CurrentUserViewModel()).environmentObject(UsersAdminViewModel())
    }
}*/


/*class FakeCurrentUserViewModel: CurrentUserViewModel {
  
let fakeUser = UserRegistered(id: "fakeId", name: "John", surname: "Doe", pseudo: "FakeAccount", profileImageUrl: "http://tigerday.org/wp-content/uploads/2013/04/Siberischer_tiger.jpg", email: "fakemail@icloud.com", phoneNumber: "0123456789", discordPseudo: "#0123FakeAccount", street: "1 rue de la paix", zipCode: "40100", city: "Dax", isAdmin: true)
  
  
  init(currentUser: UserRegistered) {
    super.init()
    self.currentUser = currentUser
  }
  
}*/
