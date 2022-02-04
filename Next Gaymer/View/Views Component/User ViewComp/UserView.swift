//
//  UserView.swift
//  Next Gaymer
//
//  Created by Fabien Saint Germain on 04/02/2022.
//

import SwiftUI
import SDWebImageSwiftUI

struct UserView: View {
  
  var currentUser: UserRegistered
  
    var body: some View {
      VStack {
        WebImage(url: URL(string: currentUser.profileImageUrl) )
          .resizable()
          .scaledToFill()
          .frame(width:150, height: 150)
          .clipped()
          .cornerRadius(75)
          .overlay(RoundedRectangle(cornerRadius: 75)
                    .stroke(Color("Purple"), lineWidth: 4))
        Text(currentUser.pseudo)
          .padding()
        VStack(alignment: .leading) {
          Text(currentUser.name)
            .padding()
          Text(currentUser.surname)
            .padding()
          Text(currentUser.email)
            .padding()
          Text(currentUser.city)
            .padding()
        }
      }
    }
}

struct UserView_Previews: PreviewProvider {
    static var previews: some View {
      UserView(currentUser: FakePreviewData.currentUser.currentUser!)
    }
}
