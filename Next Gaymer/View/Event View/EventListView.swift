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
      
      List(eventListModel.eventList.sorted(by:
                                            { $0.date.compare($1.date) == .orderedAscending }
                                          ), id: \.id) { event in
        NavigationLink {
          EventDetailView(eventDetailModel: EventDetailViewModel(event: event))
        } label: {
          EventViewCell(event: event)
        }
      }
      .refreshable {
        eventListModel.fetchEventList()
      }
      .listStyle(.plain)
      .modifier(EmptyDataModifier(
        items: eventListModel.eventList,
        placeholder: Text(NSLocalizedString("noMoreEvent", comment: ""))))
      
      .navigationTitle(NSLocalizedString("events", comment: ""))
      .navigationBarTitleDisplayMode(.large)
      .toolbar {
        ToolbarItem(placement: .navigationBarTrailing) {
          NavigationLink {
            MyEventListView()
          } label: {
            Text(NSLocalizedString("myEvents", comment: ""))
          }
        }
        ToolbarItem(placement: .navigationBarLeading) {
          if currentUser.currentUser?.isAdmin ?? false {
            NavigationLink {
              EventCreationAdminView()
            } label: {
              Image(systemName: "plus")
            }
          }
        }
      }
    }
    .navigationViewStyle(.stack)
    .alert(eventListModel.errorMessage, isPresented: $eventListModel.showAlert) {}
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
