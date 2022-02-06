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
    NavigationView {
      List(myEventModel.myEventList, id: \.id) { event in
        NavigationLink {
          MyEventDetailView(
            myEventDetailModel: MyEventDetailViewModel(
              selectedEvent: event))
        } label: {
          EventViewCell(event: event)
        }
      }
      .navigationTitle(NSLocalizedString("myEvent", comment: ""))
      //.navigationBarTitleDisplayMode(.inline)
      .navigationViewStyle(.stack)
      .refreshable {
        myEventModel.updateEvent()
      }
      .modifier(EmptyDataModifier(items: myEventModel.myEventList, placeholder: Text(NSLocalizedString("emptyEvent", comment: ""))))
    }
  }
}

struct MyEventListView_Previews: PreviewProvider {
  static var previews: some View {
    MyEventListView().environmentObject(FakePreviewData.currentUser)
  }
}
