//
//  UsersListAdminView2.swift
//  Next Gaymer
//
//  Created by Fabien Saint Germain on 23/01/2022.
//

import SwiftUI

struct PlayerView: View {
    let name: String

    var body: some View {
        Text("Selected player: \(name)")
            .font(.largeTitle)
    }
}

struct UsersListAdminView2: View {
  
  let players = [
      "Roy Kent",
      "Richard Montlaur",
      "Dani Rojas",
      "Jamie Tartt",
  ]
  
  
    var body: some View {
      NavigationView{
        List(players, id: \.self) { player in
          NavigationLink(destination: PlayerView(name: player)) {
            HStack {
              Image(systemName: "person.fill")
              VStack(alignment: .leading) {
                Text("Nom")
                  .padding(.bottom)
                Text(player)
              }
              .padding(.leading)

            }
          }
        }
      }
    }
}

struct UsersListAdminView2_Previews: PreviewProvider {
    static var previews: some View {
        UsersListAdminView2()
    }
}
