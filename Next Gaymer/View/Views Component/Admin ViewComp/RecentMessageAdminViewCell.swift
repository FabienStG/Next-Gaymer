//
//  RecentMessageAdminViewCell.swift
//  Next Gaymer
//
//  Created by Fabien Saint Germain on 03/02/2022.
//

import SwiftUI
import SDWebImageSwiftUI

struct RecentMessageAdminViewCell: View {
  
  var recentMessage: RecentMessage
  
    var body: some View {
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

struct RecentMessageAdminViewCell_Previews: PreviewProvider {
    static var previews: some View {
      RecentMessageAdminViewCell(recentMessage: FakePreviewData.fakeRecentMessage)
    }
}
