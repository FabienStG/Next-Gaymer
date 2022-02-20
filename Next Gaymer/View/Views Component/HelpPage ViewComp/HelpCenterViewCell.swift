//
//  HelpCenterViewCell.swift
//  Next Gaymer
//
//  Created by Fabien Saint Germain on 20/02/2022.
//

import SwiftUI

struct HelpCenterViewCell: View {
  
  var helpCenter: HelpCenter
  
    var body: some View {
      VStack(alignment: .leading) {
        Text(helpCenter.name)
          .font(.title)
          .foregroundColor(.accentColor)
          .padding(.bottom)

        Link(destination: helpCenter.phoneNumberURL) {
          Text(helpCenter.phoneNumber)
            .underline()
            .foregroundColor(.black)
        }
        .padding(.bottom)

        Link(helpCenter.url.absoluteString, destination: helpCenter.url)
        
        Text(helpCenter.description)
          .padding(.top)
          .multilineTextAlignment(.leading)
          .font(.body)
      }
    }
}

struct HelpCenterViewCell_Previews: PreviewProvider {
    static var previews: some View {
      HelpCenterViewCell(helpCenter: FakePreviewData.helpCenter)
    }
}
