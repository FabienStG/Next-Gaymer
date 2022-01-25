//
//  MainMessageAdminView2.swift
//  Next Gaymer
//
//  Created by Fabien Saint Germain on 25/01/2022.
//
/*
import SwiftUI
import SDWebImageSwiftUI

struct MainMessageAdminView2: View {
  
  @StateObject var mainMessageAdminModel = MainMessageAdminViewModel()
  
  @EnvironmentObject var currentUser: CurrentUserViewModel
  
    var body: some View {
      NavigationView {
        ScrollView {
        NavigationLink(isActive: $mainMessageAdminModel.isShowingLogchat) {
          ChatLogAdminView(selectedUser: mainMessageAdminModel.selectedUser)
        } label: {

          ForEach(mainMessageAdminModel.recentMessages) { recentMessage in
            Button {
              mainMessageAdminModel.fetchSelectedUser(currentUser: currentUser.currentUser!, messageSelected: recentMessage)
            } label: {
              HStack(spacing: 16) {
                WebImage(url: URL(string: recentMessage.profileImageUrl))
                  .resizable()
                  .scaledToFill()
                  .frame(width: 64, height: 64)
                  .clipped()
                  .cornerRadius(64)
                  .overlay(RoundedRectangle(cornerRadius: 64)
                            .stroke(Color("Purple"), lineWidth: 2))
                  .shadow(radius: 5)
                VStack(alignment: .leading, spacing: 8) {
                  Text(recentMessage.pseudo)
                    .font(.system(size: 16, weight: .bold))
                    .foregroundColor(Color(.label))
                    .multilineTextAlignment(.leading)
                  Text(recentMessage.text)
                    .font(.system(size: 14))
                    .foregroundColor(Color(.darkGray))
                    .multilineTextAlignment(.leading)
                }
                Spacer()
                Text(recentMessage.timeAgo)
                  .font(.system(size: 14, weight: .semibold))
                  .foregroundColor(Color(.label))
              }
            }
          }
        }
      }
      }
    }
}

struct MainMessageAdminView2_Previews: PreviewProvider {
    static var previews: some View {
        MainMessageAdminView2().environmentObject(CurrentUserViewModel())
    }
}
*/
