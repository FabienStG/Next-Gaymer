//
//  EventListAdminView.swift
//  Next Gaymer
//
//  Created by Fabien Saint Germain on 24/01/2022.
//

import SwiftUI

struct EventListView: View {
  
  @EnvironmentObject var currentUser: CurrentUserViewModel
  
    var body: some View {
      NavigationView {
        VStack {
          HStack {
            
          Spacer()
            if currentUser.currentUser?.isAdmin ?? true{
              NavigationLink {
                
              } label: {
                Image(systemName: "plus")
              }
            }
        NavigationLink {
          //
        } label: {
          Text("Mes évènements")
        }
        .padding(.trailing)
          }
        List(0..<15) { even in
          Text("Évenement")
            .navigationTitle("Évènements")
        }

      }

      }
    }
}

struct EventListView_Previews: PreviewProvider {
    static var previews: some View {
      EventListView().environmentObject(CurrentUserViewModel())
    }
}
