//
//  NewMessageView.swift
//  Next Gaymer
//
//  Created by Fabien Saint Germain on 22/01/2022.
//

import SwiftUI
import SDWebImageSwiftUI

struct UsersListAdminView: View {
  
  @StateObject var usersAdminModel = UsersAdminViewModel()
  
  var body: some View {
      NavigationView {
        VStack {
          NavigationLink {
            SelfDetailsView()
          } label: {
            Text("Afficher son profil")
          }

       List(usersAdminModel.usersLimitedDetailsList.sorted(by: { $0.pseudo < $1.pseudo })) { user in
         NavigationLink {
          UserDetailsAdminView(userDetails: UserDetailsAdminViewModel(selectedUser: user))
         } label: {
           HStack(spacing: 16) {
             WebImage(url: URL(string: user.profileImageUrl))
               .resizable()
               .scaledToFill()
               .frame(width: 70, height: 70)
               .clipped()
               .cornerRadius(70)
               .overlay(RoundedRectangle(cornerRadius: 70)
                          .stroke(user.isAdmin ? Color(.yellow) : Color("Purple"),
                                 lineWidth: 2))
           }
           Text(user.pseudo)
          }
         .navigationTitle("Utilisateurs")
        }
      }
    }
  }
}

struct NewMessageView_Previews: PreviewProvider {
    static var previews: some View {
      UsersListAdminView()
    }
}
