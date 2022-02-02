//
//  UserAdminViewCell.swift
//  Next Gaymer
//
//  Created by Fabien Saint Germain on 01/02/2022.
//

import SwiftUI
import SDWebImageSwiftUI

struct UserAdminViewCell: View {
  
  var user: UserDetails
  
  var body: some View {
    
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
        .shadow(radius: 5)
      
      Text(user.pseudo)
    }
  }
}

struct UserAdminViewCell_Previews: PreviewProvider {
  static var previews: some View {
    UserAdminViewCell(user: FakePreviewData.fakeSelectedUser)
  }
}
