//
//  TabBarRouter.swift
//  Next Gaymer
//
//  Created by Fabien Saint Germain on 18/01/2022.
//

import SwiftUI

class TabBarRouter: ObservableObject {

  @Published var currentTab: Tab = .home

}

  enum Tab: String, CaseIterable {

    case home = "house.fill"
    case message = "message.fill"
    case map = "mappin.circle.fill"
    case profile = "person.crop.circle.fill"

}
