//
//  UserLogStatus.swift
//  Next Gaymer
//
//  Created by Fabien Saint Germain on 14/02/2022.
//

import SwiftUI

class UserLogStatus {
  
  static let shared = UserLogStatus()
  private init () {}
  
  //
  // MARK: - App Storage Log Status
  //
  /// Save the log status in the app to avoid a relog when the user leave
  @AppStorage("log_status") var logStatus = false
}
