//
//  ViewRouter.swift
//  Next Gaymer
//
//  Created by Fabien Saint Germain on 13/01/2022.
//

import SwiftUI

class ViewRouter: ObservableObject {
     
    @Published var currentPage: Page = .loggedOut
}

enum Page {
    
    case loggedOut
    case loggedIn
}
