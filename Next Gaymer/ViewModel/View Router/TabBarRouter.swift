//
//  TabBarRouter.swift
//  Next Gaymer
//
//  Created by Fabien Saint Germain on 18/01/2022.
//

import SwiftUI

class TabBarRouter: ObservableObject {

  @Published var currentTab: Tab = .event

}

  enum Tab: String, CaseIterable {

    case event = "calendar.circle.fill"
    case message = "message.fill"
    case help = "questionmark.circle.fill"
    case profile = "person.crop.circle.fill"

}
