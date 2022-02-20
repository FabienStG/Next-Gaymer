//
//  MainMessageView.swift
//  Next Gaymer
//
//  Created by Fabien Saint Germain on 24/01/2022.
//

import SwiftUI

struct MainMessageView: View {
  
  @StateObject var mainMessageModel = MainMessageViewModel()
  
  @EnvironmentObject var currentUser: CurrentUserViewModel
  
  var body: some View {
    NavigationView {
      List {
        ForEach(mainMessageModel.recentMessages, id: \.id!) { recentMessage in
          Button {
            mainMessageModel.fetchSelectedUser(currentUser: currentUser.currentUser!,
                                               messageSelected: recentMessage)
          } label: {
            RecentMessageAdminViewCell(recentMessage: recentMessage)
          }
        }
        .onDelete(perform: mainMessageModel.deleteRecentMessage)
     }
      .background(
        NavigationLink(isActive: $mainMessageModel.isShowingLogchat) {
          ChatLogView(selectedUser:
                        SelectedUserViewModel(
                          selectedUser: mainMessageModel.selectedUser!))
        } label: { EmptyView() }
      )
      .modifier(EmptyDataModifier(
        items: mainMessageModel.recentMessages,
        placeholder:
          Text(NSLocalizedString("noMessage", comment: ""))
          .multilineTextAlignment(.center)))
      
      .navigationTitle(NSLocalizedString("chat", comment: ""))
      .navigationBarTitleDisplayMode(.large)
      .toolbar {
        ToolbarItem(placement: .navigationBarTrailing) {
          NavigationLink {
            AdminListUserView()
          } label: {
            Image(systemName: "plus")
          }
        }
      }
    }
    .navigationViewStyle(.stack)
    .alert(mainMessageModel.errorMessage,
           isPresented: $mainMessageModel.showAlert) {}
     .onAppear {
       mainMessageModel.fetchRecentMessages()
     }
  }
}

struct MainMessageView_Previews: PreviewProvider {
    static var previews: some View {
        MainMessageView().environmentObject(FakePreviewData.currentAdminUser)
    }
}
