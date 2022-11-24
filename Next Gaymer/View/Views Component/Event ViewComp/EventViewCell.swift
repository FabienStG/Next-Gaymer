//
//  EventViewCell.swift
//  Next Gaymer
//
//  Created by Fabien Saint Germain on 01/02/2022.
//

import SwiftUI

struct EventViewCell: View {
  
  var event: EventCreated
  
  var body: some View {
    HStack {
      AsyncImage(url: URL(string: event.imageUrl))
        .clipped()
        .frame(width: 110, height: 80)
        .scaledToFit()
        .cornerRadius(4)
        .padding(.vertical, 4)
      VStack(alignment: .leading, spacing: 2) {
        Text(event.eventName)
          .fontWeight(.semibold)
          .lineLimit(1)
          .minimumScaleFactor(0.5)
        HStack(spacing: 50) {
        Text(event.dateString)
          .font(.subheadline)
          .foregroundColor(.secondary)
          Text(event.town)
            .font(.subheadline)
            .foregroundColor(.secondary)
        }
      }
    }
  }
}

struct EventViewCell_Previews: PreviewProvider {
  static var previews: some View {
    EventViewCell(event: FakePreviewData.fakeOnlineEvent)
  }
}

