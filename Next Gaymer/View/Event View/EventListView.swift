//
//  EventListAdminView.swift
//  Next Gaymer
//
//  Created by Fabien Saint Germain on 24/01/2022.
//
import SwiftUI

struct EventListView: View {
  
  @EnvironmentObject var currentUser: CurrentUserViewModel
  @StateObject var eventListModel = EventListViewModel()
  
  var body: some View {
    NavigationView {
      VStack(alignment: .trailing) {
        HStack() {
          if currentUser.currentUser?.isAdmin ?? false {
            NavigationLink {
              EventCreationAdminView()
            } label: {
              Text("Créer un évènement")
                .padding(.leading)
            }
            Spacer()
          }
          NavigationLink {
            //
          } label: {
            Text("Mes inscriptions")
          }
          .padding(.trailing)
        }
        List(eventListModel.eventList, id: \.id) { event in
          EventViewCell(event: event)
        }
        .listStyle(.plain)
      }
      .navigationTitle("Évènements")
    }
    .onAppear {
      eventListModel.fetchEventList()
    }
  }
}

struct EventListView_Previews: PreviewProvider {
    static var previews: some View {
      EventListView().environmentObject(CurrentUserViewModel())
    }
}
