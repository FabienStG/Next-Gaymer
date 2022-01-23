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
     List(usersAdminModel.usersLimitedDetailsList) { user in
       NavigationLink {
        UserDetailsAdminView(userDetails: UserDetailsAdminViewModel(selectedUser: user))
       } label: {
         Text(user.name)
       }

       
        }

         /* ForEach(usersAdminModel.usersLimitedDetailsList, id: \.id) { user in
            NavigationLink(tag: user.id, selection: $usersAdminModel.selectedUser) {
              UserDetailsAdminView()
            } label: {
            Button {
              usersAdminModel.selectedUser = user
            } label: {
              HStack(spacing: 16) {
                WebImage(url: URL(string: user.profileImageUrl))
                  .resizable()
                  .scaledToFill()
                  .frame(width: 50, height: 50)
                  .clipped()
                  .cornerRadius(50)
                  .overlay(RoundedRectangle(cornerRadius: 50)
                            .stroke(user.isAdmin ? Color(.red) : Color(.label), lineWidth: 2))
              }
              Text(user.pseudo)
                .foregroundColor(Color(.label))
            }
              Spacer()
            }
            .padding(.horizontal)
          }
          .background(Color.black.opacity(0.04).ignoresSafeArea())
          Divider()
            .padding(.vertical, 8)
        }
        .background(Color.black.opacity(0.04).ignoresSafeArea())
          */
      }
    }
}

struct NewMessageView_Previews: PreviewProvider {
    static var previews: some View {
      UsersListAdminView()
    }
}

/*NavigationView {
 NavigationLink(isActive: $usersAdminModel.isShowingUsersDetailsView) {
   UserDetailsAdminView()
 } label: {
   ScrollView {
     ForEach(usersAdminModel.usersLimitedDetailsList) { user in
       Button {
         usersAdminModel.selectedUser = user
         usersAdminModel.isShowingUsersDetailsView = true
       } label: {
         HStack(spacing: 16) {
           WebImage(url: URL(string: user.profileImageUrl))
             .resizable()
             .scaledToFill()
             .frame(width: 50, height: 50)
             .clipped()
             .cornerRadius(50)
             .overlay(RoundedRectangle(cornerRadius: 50)
                       .stroke(user.isAdmin ? Color(.red) : Color("Purple"), lineWidth: 2))
         }
         Text(user.pseudo)
           .foregroundColor(Color(.label))
         Divider()
       }
       Spacer()
     }
     .padding(.horizontal)
   }
   .padding(.vertical, 8)*/
