//
//  AdminListUserView.swift
//  Next Gaymer
//
//  Created by Fabien Saint Germain on 05/02/2022.
//

import SwiftUI

struct AdminListUserView: View {
  
  @StateObject var adminListModel = AdminListUserViewModel()
  
    var body: some View {

        List(adminListModel.adminList
              .sorted(by: { $0.pseudo < $1.pseudo })) { user in
          NavigationLink {
            ChatLogView(selectedUser: SelectedUserViewModel(selectedUser: user))
          } label: {
            UserAdminViewCell(user: user)
          }
        }
        .modifier(EmptyDataModifier(
          items: adminListModel.adminList,
          placeholder: Text(NSLocalizedString("failFetchAdminList", comment: ""))))
      .navigationViewStyle(.stack)
      .alert(adminListModel.errorMessage,
             isPresented: $adminListModel.showAlert) {}
    }
}

struct AdminListUserView_Previews: PreviewProvider {
    static var previews: some View {
        AdminListUserView()
    }
}
