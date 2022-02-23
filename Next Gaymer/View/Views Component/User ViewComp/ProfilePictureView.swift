//
//  ProfilePictureView.swift
//  Next Gaymer
//
//  Created by Fabien Saint Germain on 19/02/2022.
//

import SwiftUI

struct ProfilePictureView: View {
  
  var url: String
  
  var body: some View {
    AsyncImage(url: URL(string: url)) { image in
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
  }
}

struct ProfilePictureView_Previews: PreviewProvider {
  static var previews: some View {
    ProfilePictureView(url: FakePreviewData.fakeSelectedUser.profileImageUrl)
  }
}
