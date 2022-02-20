//
//  HelpPageViewModel.swift
//  Next Gaymer
//
//  Created by Fabien Saint Germain on 20/02/2022.
//

import SwiftUI
//
// MARK: - Help Page View Model
//

/// This class just provide to the view the array of centers
class HelpPageViewModel: ObservableObject {
  //
  // MARK: - Published propertie
  //
  @Published var helpCenters = HelpCenters().centersList
}
