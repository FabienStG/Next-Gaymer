//
//  LogoView.swift
//  Next Gaymer
//
//  Created by Fabien Saint Germain on 13/01/2022.
//

import SwiftUI

struct LogoView: View {
    var body: some View {
        Image("NG logo")
            .resizable()
            .aspectRatio(contentMode: .fit)
            .frame(width: 150, height: 150, alignment: .center)
    }
}

struct LogoView_Previews: PreviewProvider {
    static var previews: some View {
        LogoView()
    }
}
