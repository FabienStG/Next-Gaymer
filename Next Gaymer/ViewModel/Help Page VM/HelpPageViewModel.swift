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
  @Published var helpCenters: [HelpCenter] = []
  
  //
  // MARK: - Initialization
  //
  init() {
    fethCenterList()
  }
  
  //
  // MARK: - Private Method
  //
  /// This function fetch the center list from firebase
  private func fethCenterList() {
    
    DataManager.shared().fetchCenterList { centerList in
      self.helpCenters = centerList
    }
  }
}
