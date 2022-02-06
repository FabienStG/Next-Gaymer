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
      List(mainMessageModel.recentMessages) { recentMessage in
        Button {
          mainMessageModel.fetchSelectedUser(currentUser: currentUser.currentUser!,
                                             messageSelected: recentMessage)
        } label: {
          RecentMessageAdminViewCell(recentMessage: recentMessage)
        }
      }
      .modifier(EmptyDataModifier(
        items: mainMessageModel.recentMessages,
        placeholder:
            Text(NSLocalizedString("noMessage", comment: ""))
          .multilineTextAlignment(.center)))
      .background(
        NavigationLink(isActive: $mainMessageModel.isShowingLogchat) {
          ChatLogView(selectedUser:
                        SelectedUserViewModel(
                          selectedUser: mainMessageModel.selectedUser!))
        } label: { EmptyView() }
      )
    }
    .navigationTitle(NSLocalizedString("chat", comment: ""))
    .toolbar {
      ToolbarItem(placement: .navigationBarTrailing) {
        if !(currentUser.currentUser?.isAdmin ?? false) {
          NavigationLink {
            UserAdminListView()
          } label: {
            Image(systemName: "plus")
          }
        }
      }
    }
    .onAppear {
      mainMessageModel.fetchRecentMessages(currentUser: currentUser.currentUser!)
    }
  }
}

struct MainMessageView_Previews: PreviewProvider {
    static var previews: some View {
      NavigationView {
        MainMessageView().environmentObject(FakePreviewData.currentAdminUser)
      }
    }
}
