//
//  NewMessageView.swift
//  Next Gaymer
//
//  Created by Fabien Saint Germain on 22/01/2022.
//
import SwiftUI

struct UsersAdminView: View {
  
  @StateObject var userListAdminModel = UserListAdminViewModel()
  
  var body: some View {
    NavigationView {
      List(userListAdminModel.userList
            .sorted(by: { $0.pseudo < $1.pseudo })) { user in
        NavigationLink {
          UserDetailsAdminView(
            userDetails: UserDetailsAdminViewModel(
              selectedUser: user))
        } label: {
          UserAdminViewCell(user: user)
        }
      }
      .refreshable {
        userListAdminModel.fetchUserList()
      }
      .modifier(EmptyDataModifier(
        items: userListAdminModel.userList,
        placeholder: Text(NSLocalizedString("noUsers", comment: ""))))
      .navigationTitle(NSLocalizedString("users", comment: ""))
      .toolbar {
        ToolbarItem(placement: .navigationBarTrailing) {
          NavigationLink {
            ProfileView()
          } label: {
            Image(systemName: "person.circle.fill")
              .font(.system(size: 20))
              .foregroundColor(Color("Purple"))
          }
        }
      }
    }
    .navigationViewStyle(.stack)
    .alert(userListAdminModel.errorMessage,
           isPresented: $userListAdminModel.showAlert) {}
  }
}

struct UsersAdminView_Previews: PreviewProvider {
  static var previews: some View {
    UsersAdminView()
  }
}
