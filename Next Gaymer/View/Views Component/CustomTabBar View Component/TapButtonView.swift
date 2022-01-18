//
//  TapButtonView.swift
//  Next Gaymer
//
//  Created by Fabien Saint Germain on 17/01/2022.
//

import SwiftUI

struct TabButton: View {
    
    var tab: Tab
    
    @Binding var animation: Namespace.ID
    @Binding var currentTab: Tab
    
    var onTap: (Tab) -> ()
    
    var body: some View {
        
        Image(systemName: tab.rawValue)
            .foregroundColor(currentTab == tab ? .white : .gray)
            .frame(width: 45, height: 45)
            .background(
                ZStack {
                    if currentTab == tab {
                        Circle()
                            .fill(Color("Purple"))
                            .matchedGeometryEffect(id: "TAB", in: animation)
                    }
                }
            )
            .frame(maxWidth: .infinity)
            .contentShape(Rectangle())
            .onTapGesture {
                if currentTab != tab {
                    onTap(tab)
                }
            }
    }
}


