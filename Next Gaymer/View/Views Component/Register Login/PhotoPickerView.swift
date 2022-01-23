//
//  PhotoPickerViewTest.swift
//  Next Gaymer
//
//  Created by Fabien Saint Germain on 18/01/2022.
//

import SwiftUI

struct PhotoPickerView: View {
    
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
                        .frame(width: 110, height: 110)
                        .clipShape(Circle())
                } else {
                    Image(systemName: "person.circle.fill")
                        .resizable()
                        .foregroundColor(.primary)
                        .frame(width: 110, height: 110)
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
