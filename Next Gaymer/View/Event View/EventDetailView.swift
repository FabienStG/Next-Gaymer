//
//  EventDetailView.swift
//  Next Gaymer
//
//  Created by Fabien Saint Germain on 02/02/2022.
//

import SwiftUI

struct EventDetailView: View {
  
  @EnvironmentObject var currentUser: CurrentUserViewModel
  @StateObject var eventDetailModel: EventDetailViewModel
  
  var body: some View {
    VStack {
      EventView(event: eventDetailModel.event)
      Button {
        eventDetailModel.registrateUserToEvent(currentUser: currentUser.currentUser!)
      } label: {
        ButtonTextView(status: $eventDetailModel.requestStatus,
                       text: NSLocalizedString("registrate", comment: ""))
      }
      .disabled(eventDetailModel.disableButton)
    }
    .toolbar {
      ToolbarItem(placement: .primaryAction) {
        if currentUser.currentUser?.isAdmin ?? true {
          Button {
            eventDetailModel.showOptions.toggle()
          } label: {
            Image(systemName: "ellipsis.circle.fill")
          }
        }
      }
    }
    .sheet(isPresented: $eventDetailModel.showRegistrants, content: {
      RegistrantListAdminView(event: eventDetailModel.event)
    })
    .confirmationDialog("cofirmation", isPresented: $eventDetailModel.showOptions, actions: {
      Button {
        eventDetailModel.showRegistrants.toggle()
      } label: {
        Text(NSLocalizedString("showRegistrantList", comment: ""))
      }
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
      .environmentObject(FakePreviewData.currentAdminUser)
  }
}
