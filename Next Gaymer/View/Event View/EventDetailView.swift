//
//  EventDetailView.swift
//  Next Gaymer
//
//  Created by Fabien Saint Germain on 02/02/2022.
//

import SwiftUI
import SDWebImageSwiftUI

struct EventDetailView: View {
  
  @EnvironmentObject var currentUser: CurrentUserViewModel
  @StateObject var eventDetailModel = EventDetailViewModel()
  
  var event: EventCreated
  
    var body: some View {
      VStack {
        Spacer()
        WebImage(url: URL(string: event.imageUrl))
          .resizable()
          .scaledToFill()
          .frame(width: 250, height: 150)
          .cornerRadius(12)
        Text(event.eventName)
          .font(.title2)
          .fontWeight(.semibold)
          .multilineTextAlignment(.center)
          .padding(.horizontal)
        HStack {
          Text(event.dateString + " " + NSLocalizedString("at", comment:""))
        }
        Text(event.description)
          .font(.body)
          .padding()
        Spacer()
        Button {
          eventDetailModel.registrateUserToEvent(currentUser: currentUser.currentUser!, event: event)
        } label: {
          Text(NSLocalizedString("registrate", comment: ""))
            .bold()
        }
        .frame(width: 150, height: 50)
        .foregroundColor(.white)
        .background(Color(.blue))
        .cornerRadius(10)
      }
      .alert(eventDetailModel.alertMessage, isPresented: $eventDetailModel.showAlert) {}
    }
}

struct EventDetailView_Previews: PreviewProvider {
    static var previews: some View {
      EventDetailView(event: FakePreviewData.fakeOnlineEvent).environmentObject(FakePreviewData.currentUser)
    }
}
