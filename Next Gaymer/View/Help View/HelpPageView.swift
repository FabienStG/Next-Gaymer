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
      ZStack {
        Color(UIColor.systemGroupedBackground).edgesIgnoringSafeArea([.all])
        ScrollView {
          ForEach(helpPageModel.helpCenters, id:\.id) { helpCenter in
            HelpCenterViewCell(helpCenter: helpCenter)
              .padding()
              .frame(width: 370 ,height: 350)
              .background(Color(UIColor.tertiarySystemBackground))
              .border(Color(UIColor.secondarySystemBackground), width: 2)
              .cornerRadius(20)
          }
        }
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
