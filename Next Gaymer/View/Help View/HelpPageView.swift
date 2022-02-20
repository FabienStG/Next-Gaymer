//
//  HelpPageView.swift
//  Next Gaymer
//
//  Created by Fabien Saint Germain on 24/01/2022.
//

import SwiftUI

struct HelpPageView: View {
  
  @StateObject var helpPageModel = HelpPageViewModel()
  
  var body: some View {
    NavigationView {
      List(helpPageModel.helpCenters) { helpCenter in
        HelpCenterViewCell(helpCenter: helpCenter)
          .padding(.bottom)
      }
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
