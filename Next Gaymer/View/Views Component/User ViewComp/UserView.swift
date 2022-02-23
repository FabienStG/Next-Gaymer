//
//  UserView.swift
//  Next Gaymer
//
//  Created by Fabien Saint Germain on 04/02/2022.
//

import SwiftUI

struct UserView: View {
  
  var currentUser: UserRegistered
  
  var body: some View {
    VStack {
      AsyncImage(url: URL(string: currentUser.profileImageUrl)) { image in
        image
          .resizable()
          .scaledToFill()
      } placeholder: {
        ProgressView()
      }
      .frame(width:150, height: 150)
      .clipped()
      .cornerRadius(75)
      .overlay(RoundedRectangle(cornerRadius: 75)
                .stroke(Color("Purple"), lineWidth: 4))
      .padding()
      Text(currentUser.pseudo)
        .padding()
      Spacer()
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
      Spacer()
    }
  }
}

struct UserView_Previews: PreviewProvider {
  static var previews: some View {
    UserView(currentUser: FakePreviewData.currentUser.currentUser!)
  }
}
