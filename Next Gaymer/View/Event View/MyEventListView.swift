//
//  MyEventListView.swift
//  Next Gaymer
//
//  Created by Fabien Saint Germain on 04/02/2022.
//

import SwiftUI

struct MyEventListView: View {
  
  @StateObject var myEventModel = MyEventListViewModel()
  
  var body: some View {
 
      List(myEventModel.eventList, id: \.id) { event in
        NavigationLink {
          MyEventDetailView(
            myEventDetailModel: MyEventDetailViewModel(
              selectedEvent: event))
        } label: {
          EventViewCell(event: event)
        }
      }
      .navigationTitle(NSLocalizedString("myEvents", comment: ""))

      .refreshable {
        myEventModel.fetchEventList()
      }
      .modifier(EmptyDataModifier(items: myEventModel.eventList, placeholder: Text(NSLocalizedString("emptyEvent", comment: ""))))
    
  }
}

struct MyEventListView_Previews: PreviewProvider {
  static var previews: some View {
    MyEventListView().environmentObject(FakePreviewData.currentUser)
  }
}
