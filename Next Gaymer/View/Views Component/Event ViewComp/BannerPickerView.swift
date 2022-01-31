//
//  BannerPickerView.swift
//  Next Gaymer
//
//  Created by Fabien Saint Germain on 30/01/2022.
//

import SwiftUI

struct BannerPickerView: View {
  
  @Binding var changeProfileImage: Bool
  @Binding var openCameraRool: Bool
  @Binding var imageSelected: UIImage
  
  var body: some View {
      ZStack(alignment: .bottomTrailing) {
          Button {
              changeProfileImage = true
              openCameraRool = true
          } label: {
              if changeProfileImage {
                  Image(uiImage: imageSelected)
                      .resizable()
                      .aspectRatio(contentMode: .fill)
                      .frame(maxWidth: .infinity, maxHeight: 80)
                      .clipped()
              } else {
                  Image("Banniere")
                      .resizable()
                      .foregroundColor(.primary)
                      .aspectRatio(contentMode: .fill)
                      .frame(maxWidth: .infinity, maxHeight: 80)
                      .clipped()
              }
          }
          Image(systemName: "plus")
              .frame(width: 30, height: 30)
              .foregroundColor(.white)
              .background(Color.gray)
              .clipShape(Circle())
      }
      .sheet(isPresented: $openCameraRool) {
          ImagePicker(selectedImage: $imageSelected)
      }
  }
}

struct BannerPickerView_Previews: PreviewProvider {
  static var previews: some View {
    BannerPickerView(changeProfileImage: .constant(false), openCameraRool: .constant(false), imageSelected: .constant(UIImage()))
  }
}
