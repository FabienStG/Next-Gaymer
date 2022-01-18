//
//  CustomTabBarViewModel.swift
//  Next Gaymer
//
//  Created by Fabien Saint Germain on 17/01/2022.
//

import SwiftUI

class CustomTabBarViewModel: ObservableObject {
    
    @Published var startAnimation = false
    
    func getOffset(_ size: CGSize, tab: Tab) -> CGFloat {
        let reduced = (size.width - 30) / 4
        let index = Tab.allCases.firstIndex { checkTab in
            return checkTab == tab
        } ?? 0
        
        return reduced * CGFloat(index)
    }
    
    func getStartOffset(_ size: CGSize) -> CGFloat {
        let reduced = (size.width - 30) / 4
        let center = (reduced - 45) / 2
        
        return center
    }
}

