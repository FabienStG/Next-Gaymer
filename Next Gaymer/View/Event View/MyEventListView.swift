//
//  MyEventListView.swift
//  Next Gaymer
//
//  Created by Fabien Saint Germain on 04/02/2022.
//

import SwiftUI

struct MyEventListView: View {
  
  @EnvironmentObject var currentuser: CurrentUserViewModel
  @StateObject var myEventModel = MyEventViewModel()
  
  var body: some View {
    List(myEventModel.myEventList, id: \.id) { event in
      EventViewCell(event: event)
    }
    .refreshable {
      myEventModel.fetchMyEventList(currentUser: currentuser.currentUser!)
    }
    .modifier(EmptyDataModifier(items: myEventModel.myEventList, placeholder: Text("Vide")))
    .onAppear {
      myEventModel.fetchMyEventList(
        currentUser: currentuser.currentUser!)
    }
  }
}

struct MyEventListView_Previews: PreviewProvider {
  static var previews: some View {
    MyEventListView().environmentObject(FakePreviewData.currentUser)
  }
}
