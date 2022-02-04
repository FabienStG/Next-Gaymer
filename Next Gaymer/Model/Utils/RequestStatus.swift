//
//  RequestStatus.swift
//  Next Gaymer
//
//  Created by Fabien Saint Germain on 27/01/2022.
//

import Foundation
//
// MARK: - Request Status
//

/// Enum used by the ViewModels to switch status dependly on the API callback
enum RequestStatus {

  case initial
  case processing
  case success
  case fail
}
