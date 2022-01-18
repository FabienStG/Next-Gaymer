//
//  HomePageView2.swift
//  Next Gaymer
//
//  Created by Fabien Saint Germain on 17/01/2022.
//

import SwiftUI

struct HomepageView: View {
    
    @Namespace var animation
    @EnvironmentObject var tabBarRouter: TabBarRouter
    @EnvironmentObject var viewRouter: ViewRouter
    
    var body: some View {
                    
        GeometryReader { proxy in
            
            let size = proxy.size
            let bottomEdge = proxy.safeAreaInsets.bottom
            
            ZStack(alignment: .bottom) {
                TabView(selection: $tabBarRouter.currentTab) {
                
                UserProfilView()
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                    .background(Color.black.opacity(0.04).ignoresSafeArea())
                    .tag(Tab.home)
                Text("Search")
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                    .background(Color.black.opacity(0.04).ignoresSafeArea())
                    .tag(Tab.search)
                Text("Liked")
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                    .background(Color.black.opacity(0.04).ignoresSafeArea())
                    .tag(Tab.liked)
                Text("Settings")
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                    .background(Color.black.opacity(0.04).ignoresSafeArea())
                    .tag(Tab.settings)
            }
            
            CustomTabBar(animation: animation, size: size, bottomEdge: bottomEdge)
                .background(Color.white)
            }
        }
        .ignoresSafeArea(.all, edges: .bottom)
    }
}

struct HomepageView_Previews: PreviewProvider {

    static var previews: some View {
        HomepageView().environmentObject(TabBarRouter())
    }
}
