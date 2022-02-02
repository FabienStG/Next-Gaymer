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
      VStack {
        HStack {
          Spacer()
          NavigationLink {
            ProfileView()
          } label: {
            Image(systemName: "person.circle.fill")
              .font(.system(size: 30))
              .foregroundColor(Color("Purple"))
              .padding(.trailing)
          }
        }
        List(usersAdminModel.usersLimitedDetailsList.sorted(by: { $0.pseudo < $1.pseudo })) { user in
          NavigationLink {
            UserDetailsAdminView(userDetails: UserDetailsAdminViewModel(selectedUser: user))
          } label: {
            UserAdminViewCell(user: user)
          }
          .navigationTitle(NSLocalizedString("users", comment: ""))
        }
      }
    }
  }
}

struct UsersAdminView_Previews: PreviewProvider {
    static var previews: some View {
      UsersAdminView()
    }
}
