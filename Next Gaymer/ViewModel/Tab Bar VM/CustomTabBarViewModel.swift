//
//  CustomTabBarViewModel.swift
//  Next Gaymer
//
//  Created by Fabien Saint Germain on 17/01/2022.
//

import SwiftUI
//
// MARK: - Custom TabBar VM
//

/// This class create the custom tabbar with the specific circle effect
class CustomTabBarViewModel: ObservableObject {
  //
  // MARK: - Mark: - Published Propertie
  //
  @Published var startAnimation = false

  //
  // MARK: - Internal Methods
  //
  /// This function is used for the animation tabbar dependly on how many icons
  func getOffset(_ size: CGSize, tab: Tab) -> CGFloat {
    let reduced = (size.width - 30) / 4
    let index = Tab.allCases.firstIndex { checkTab in
      return checkTab == tab
    } ?? 0

    return reduced * CGFloat(index)
  }
  
  /// This fuction also participate to the animation tab bar
  func getStartOffset(_ size: CGSize) -> CGFloat {
    let reduced = (size.width - 30) / 4
    let center = (reduced - 45) / 2

    return center
  }
}
