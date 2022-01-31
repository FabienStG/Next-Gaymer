//
//  PlaceAnnotationView.swift
//  Next Gaymer
//
//  Created by Fabien Saint Germain on 26/01/2022.
//

import SwiftUI

struct PlaceAnnotationView: View {
  
  let location: Location
  @State private var showTitle = false
  
    var body: some View {
      VStack(spacing: 0) {
        VStack {
          Text(location.name)
            .font(.callout)
            .bold()
          Text(location.adress)
            .font(.callout)
          Text(location.phoneNumber)
        }
        .padding(5)
        .background(Color(.white))
        .cornerRadius(10)
        .opacity(showTitle ? 1 : 0)
        Image(systemName: "mappin.circle.fill")
          .font(.title)
          .foregroundColor(Color("Purple"))
        
        Image(systemName: "arrowtriangle.down.fill")
          .font(.caption)
          .foregroundColor(Color("Purple"))
          .offset(x: 0, y: -5)
      }
      .onTapGesture {
        withAnimation(.easeInOut) {
          showTitle.toggle()
        }
      }
    }
}

struct PlaceAnnotationView_Previews: PreviewProvider {
    static var previews: some View {
      PlaceAnnotationView(location: FakePreviewData.fakeLocation)
    }
}
