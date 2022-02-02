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
        VStack {
          Text("Liste des contacts d'associations d'aide")
          NavigationLink {
            MapView()
          } label: {
            Text(NSLocalizedString("showMap", comment: ""))
          }
          }
        .navigationTitle(NSLocalizedString("helpCenters", comment: ""))
        }
    }
}

struct HelpPageView_Previews: PreviewProvider {
    static var previews: some View {
        HelpPageView()
    }
}
