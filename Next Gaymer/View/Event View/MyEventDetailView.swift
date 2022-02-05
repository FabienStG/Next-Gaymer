//
//  MyEventDetailView.swift
//  Next Gaymer
//
//  Created by Fabien Saint Germain on 04/02/2022.
//

import SwiftUI

struct MyEventDetailView: View {
  
  @StateObject var myEventDetailModel: MyEventDetailViewModel
  @EnvironmentObject var currentUser: CurrentUserViewModel
  
    var body: some View {
      VStack {
        EventView(event: myEventDetailModel.selectedEvent)
        Button {
          myEventDetailModel.removeUserFromEvent(currentUser: currentUser.currentUser!)
        } label: {
          ButtonTextView(status: $myEventDetailModel.requestStatus,
                         text: NSLocalizedString("cancelRegistration", comment: ""))
        }
      }
      .alert(myEventDetailModel.message, isPresented: $myEventDetailModel.showAlert) {}
      .onReceive(myEventDetailModel.$requestStatus) { newValue in
        if myEventDetailModel.requestStatus == .success {
          currentUser.fetchCurrentUser()
        }
      }
    }
}

struct MyEventDetailView_Previews: PreviewProvider {
    static var previews: some View {
      MyEventDetailView(
        myEventDetailModel: MyEventDetailViewModel(
          selectedEvent: FakePreviewData.fakeOnlineEvent))
        .environmentObject(FakePreviewData.currentUser)
    }
}
