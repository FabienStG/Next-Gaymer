//
//  HelpPageView.swift
//  Next Gaymer
//
//  Created by Fabien Saint Germain on 24/01/2022.
//

import SwiftUI

struct HelpPageView: View {
  
  var body: some View {
    NavigationView {
      Text("Liste des contacts d'associations d'aide")
        .navigationTitle(NSLocalizedString("helpCenters", comment: ""))
        .toolbar {
          ToolbarItem(placement: .navigationBarTrailing) {
            NavigationLink {
              MapView()
            } label: {
              Image(systemName: "map.circle.fill")
            }
          }
        }
    }
    .navigationViewStyle(.stack)
  }
}

struct HelpPageView_Previews: PreviewProvider {
  static var previews: some View {
    HelpPageView()
  }
}
