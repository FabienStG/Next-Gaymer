//
//  UserLimitedView.swift
//  Next Gaymer
//
//  Created by Fabien Saint Germain on 04/02/2022.
//

import SwiftUI

struct UserLimitedView: View {
  
  var userDetails: UserDetails
  
  var body: some View {
    VStack {
      AsyncImage(url: URL(string: userDetails.profileImageUrl)) { image in
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
      Text(userDetails.pseudo)
        .padding()
      VStack(alignment: .leading) {
        Spacer()
        Text(userDetails.name)
          .padding()
        Text(userDetails.surname)
          .padding()
        Text(userDetails.email)
          .padding()
        Text(userDetails.city)
          .padding()
        Spacer()
      }
    }
  }
}

struct UserLimitedView_Previews: PreviewProvider {
    static var previews: some View {
      UserLimitedView(userDetails: FakePreviewData.fakeSelectedUser)
    }
}
