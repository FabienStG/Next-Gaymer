//
//  TabBarRouter.swift
//  Next Gaymer
//
//  Created by Fabien Saint Germain on 18/01/2022.
//

import SwiftUI
//
// MARK: - TabBar Router
//

/// This class manage manage the tab who's showed
class TabBarRouter: ObservableObject {
  //
  // MARK: - Published Propertie
  //
  @Published var currentTab: Tab = .event

}

//
// MARK: - Tab Enum
//

/// Used for the tab bar and the icon
enum Tab: String, CaseIterable {
  
  case event = "calendar.circle.fill"
  case message = "message.fill"
  case help = "questionmark.circle.fill"
  case profile = "person.crop.circle.fill"
  
}
