//
//  CustomTabBar.swift
//  Next Gaymer
//
//  Created by Fabien Saint Germain on 17/01/2022.
//

import SwiftUI

struct CustomTabBar: View {

    @State var animation: Namespace.ID
    @State var size: CGSize
    @State var bottomEdge: CGFloat

    @StateObject var customTabBarModel = CustomTabBarViewModel()
    @EnvironmentObject var tabBarRouter: TabBarRouter
    
    var body: some View {
        
        HStack(spacing: 0) {
            ForEach(Tab.allCases, id: \.rawValue) { tab in
                
                TabButton(tab: tab, animation: $animation, currentTab: $tabBarRouter.currentTab) { pressedTab in
                    withAnimation(.spring()) {
                        customTabBarModel.startAnimation = true
                    }
                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.15) {
                        withAnimation(.interactiveSpring(response: 0.7, dampingFraction: 0.8, blendDuration: 0.8)) {
                            tabBarRouter.currentTab = pressedTab
                        }
                    }
                    
                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.45) {
                        withAnimation(.interactiveSpring(response: 0.7, dampingFraction: 0.8, blendDuration: 0.8)) {
                            customTabBarModel.startAnimation = false
                        }
                    }
                }
            }
        }
        .background(CircleBackgroundView(startAnimation: $customTabBarModel.startAnimation, bottomEdge: $bottomEdge)
                        .offset(x: customTabBarModel.getStartOffset(size))
                        .offset(x: customTabBarModel.getOffset(size, tab: tabBarRouter.currentTab))
            , alignment: .leading
        )
        .padding(.horizontal, 15)
        .padding(.top, 7)
        .padding(.bottom, bottomEdge == 0 ? 23 : bottomEdge)
    }
}
