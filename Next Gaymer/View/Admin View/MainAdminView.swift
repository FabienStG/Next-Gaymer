//
//  MainAdminView.swift
//  Next Gaymer
//
//  Created by Fabien Saint Germain on 24/01/2022.
//

import SwiftUI

struct MainAdminView: View {
    var body: some View {
      NavigationView {
        VStack {
          HStack {
            
          Spacer()
        NavigationLink {
          //
        } label: {
          Text("Mes évènements")
        }
        .padding(.trailing)
          }
        List(0..<15) { even in
          Text("Évenement")
        }
        
      }
        .navigationTitle("Évènements")
      }
    }
}

struct MainAdminView_Previews: PreviewProvider {
    static var previews: some View {
        MainAdminView()
    }
}
