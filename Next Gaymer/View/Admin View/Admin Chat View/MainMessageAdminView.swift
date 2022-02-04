//
//  MainMessageAdminView.swift
//  Next Gaymer
//
//  Created by Fabien Saint Germain on 24/01/2022.
//

import SwiftUI
import SDWebImageSwiftUI

struct MainMessageAdminView: View {
  
  @StateObject var mainMessageAdminModel = MainMessageAdminViewModel()
  
  @EnvironmentObject var currentUser: CurrentUserViewModel
  
    var body: some View {
      NavigationView {
        List(mainMessageAdminModel.recentMessages) { recentMessage in
          Button {
            mainMessageAdminModel.fetchSelectedUser(currentUser: currentUser.currentUser!,
                                                    messageSelected: recentMessage)
          } label: {
            RecentMessageAdminViewCell(recentMessage: recentMessage)
          }

        }
        .modifier(EmptyDataModifier(
          items: mainMessageAdminModel.recentMessages,
          placeholder: Text(NSLocalizedString("noMessageAdmin", comment: ""))
            .multilineTextAlignment(.center)))
        .background(
          NavigationLink(isActive: $mainMessageAdminModel.isShowingLogchat) {
            ChatLogAdminView(selectedUser:
                              SelectedUserViewModel(
                                selectedUser: mainMessageAdminModel.selectedUser!))
          } label: { EmptyView() }
        )
      }
      .navigationTitle(NSLocalizedString("chat", comment: ""))
      .onAppear {
        mainMessageAdminModel.fetchRecentMessages(currentUser: currentUser.currentUser!)
      }
    }
}

struct MainMessageAdminView_Previews: PreviewProvider {
    static var previews: some View {
      NavigationView {
        MainMessageAdminView().environmentObject(FakePreviewData.currentAdminUser)
      }
    }
}
