//
//  NewMessageView.swift
//  Next Gaymer
//
//  Created by Fabien Saint Germain on 22/01/2022.
//
import SwiftUI
import SDWebImageSwiftUI

struct UsersAdminView: View {
  
  @StateObject var usersAdminModel = UsersAdminViewModel()
  
  var body: some View {
    NavigationView {
      List(usersAdminModel.usersLimitedDetailsList
            .sorted(by: { $0.pseudo < $1.pseudo })) { user in
        NavigationLink {
          UserDetailsAdminView(userDetails: UserDetailsAdminViewModel(selectedUser: user))
        } label: {
          UserAdminViewCell(user: user)
        }
      }
      .modifier(EmptyDataModifier(
        items: usersAdminModel.usersLimitedDetailsList,
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
    .alert(usersAdminModel.errorMessage, isPresented: $usersAdminModel.showAlert) {}
  }
}

struct UsersAdminView_Previews: PreviewProvider {
  static var previews: some View {
    UsersAdminView()
  }
}
