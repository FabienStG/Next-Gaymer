//
//  RegistrantListAdminView.swift
//  Next Gaymer
//
//  Created by Fabien Saint Germain on 05/02/2022.
//

import SwiftUI

struct RegistrantListAdminView: View {
  
 var event: EventCreated
  
  @StateObject var registrantListAdminModel = RegistrantListAdminViewModel()
  
    var body: some View {
      List(registrantListAdminModel.registrantList, id: \.id) { user in
        Button {
          registrantListAdminModel.confirmed.toggle()
        } label: {
        HStack {
          VStack {
            Text(user.pseudo)
            HStack {
            Text(user.name)
            Text(user.surname)
            }
          }
          Image(systemName: registrantListAdminModel.confirmed ? "checkmark.circle.fill" : "xmark.circle.fill")
        }
      }
      }
      .onAppear {
        registrantListAdminModel.fetchRegistrantList(event: event)
      }
    }
}

struct RegistrantListAdminView_Previews: PreviewProvider {
    static var previews: some View {
      RegistrantListAdminView(event: FakePreviewData.fakeOnlineEvent)
    }
}
