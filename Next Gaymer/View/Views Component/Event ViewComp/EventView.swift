//
//  EventView.swift
//  Next Gaymer
//
//  Created by Fabien Saint Germain on 01/02/2022.
//

import SwiftUI
import SDWebImageSwiftUI

struct EventView: View {
  
  @Binding var event: EventCreated
  
    var body: some View {
      ZStack {
        WebImage(url: URL(string: event.imageUrl))
          .resizable()
          .aspectRatio(contentMode: .fill)
          .frame(maxWidth: .infinity, maxHeight: 100)
          .clipped()
        if !event.isOffline {
          HStack {
            Spacer()
            VStack {
              Spacer()
            Image("Twitch logo")
              .resizable()
              .aspectRatio(contentMode: .fit)
              .background(Color(.white))
              .frame(width: 70, height: .infinity)
              .cornerRadius(5)
            }
          }
          .frame(height: 80)
        }
        Text(event.date.formatted())
          .foregroundColor(.white)
      }
    }
}

struct EventView_Previews: PreviewProvider {
    static var previews: some View {
      EventView(event: .constant(FakePreviewData.fakeOnlineEvent))
    }
}
