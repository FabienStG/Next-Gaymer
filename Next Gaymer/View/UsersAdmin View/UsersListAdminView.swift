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
        ScrollView {
          ForEach(usersAdminModel.usersLimitedDetailsList, id: \.id) { user in
            NavigationLink(isActive: $usersAdminModel.isShowingUsersDetailsView) {
              UserDetailsAdminView()
            } label: {
            Button {
              usersAdminModel.selectedUser = user
              usersAdminModel.isShowingUsersDetailsView.toggle()
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
      }
      .environmentObject(usersAdminModel)

    }
}

struct NewMessageView_Previews: PreviewProvider {
    static var previews: some View {
      UsersListAdminView().environmentObject(UsersAdminViewModel())
    }
}
