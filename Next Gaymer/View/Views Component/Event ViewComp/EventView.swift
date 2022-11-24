//
//  EventView.swift
//  Next Gaymer
//
//  Created by Fabien Saint Germain on 01/02/2022.
//

import SwiftUI

struct EventView: View {
  
  var event: EventCreated
  
    var body: some View {
      VStack {
          AsyncImage(url: URL(string: event.imageUrl))
          .scaledToFill()
          .frame(width: 250, height: 150)
          .cornerRadius(12)
        Text(event.eventName)
          .font(.title2)
          .fontWeight(.semibold)
          .multilineTextAlignment(.center)
          .padding(.horizontal)
        VStack(spacing: 15) {
          Text(event.date.formatted())
          if event.isOffline {
          Text(NSLocalizedString("availablePlaces", comment: "") +
               " \(event.maximumPlaces - event.takenPlaces)" )
              .font(.title3)
          }
        }
        Spacer()
        Text(event.description)
          .font(.body)
          .padding()
        Spacer()
      }
    }
}

struct EventView_Previews: PreviewProvider {
    static var previews: some View {
      EventView(event: FakePreviewData.fakeOnlineEvent)
    }
}
