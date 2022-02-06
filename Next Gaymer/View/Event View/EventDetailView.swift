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
  @StateObject var eventDetailModel: EventDetailViewModel
  
    var body: some View {
      VStack {
        EventView(event: eventDetailModel.event)
     
        Button {
          eventDetailModel.registrateUserToEvent(currentUser: currentUser.currentUser!,
                                                 event: eventDetailModel.event)
        } label: {
          ButtonTextView(status: $eventDetailModel.requestStatus,
                         text: NSLocalizedString("registrate", comment: ""))
        }
        .disabled(eventDetailModel.disableButton)
        if currentUser.currentUser?.isAdmin ?? true {
          
          Button {
            eventDetailModel.showRegistrants.toggle()
          } label: {
            Text("Liste des inscrits")
          }
        }
      }
      .sheet(isPresented: $eventDetailModel.showRegistrants, content: {
        RegistrantListAdminView(event: eventDetailModel.event)
      })
      .alert(eventDetailModel.alertMessage, isPresented: $eventDetailModel.showAlert) {}
      .onReceive(eventDetailModel.$requestStatus) { newValue in
        if eventDetailModel.requestStatus == .success {
          currentUser.fetchCurrentUser()
        }
      }
    }
}

struct EventDetailView_Previews: PreviewProvider {
    static var previews: some View {
      EventDetailView(eventDetailModel:
                        EventDetailViewModel(event: FakePreviewData.fakeOnlineEvent))
        .environmentObject(FakePreviewData.currentUser)
    }
}
