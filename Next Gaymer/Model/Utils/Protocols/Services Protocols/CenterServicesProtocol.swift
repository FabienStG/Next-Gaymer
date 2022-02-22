//
//  CenterServicesProtocol.swift
//  Next Gaymer
//
//  Created by Fabien Saint Germain on 22/02/2022.
//

import Foundation
//
// MARK: - Center Services Procotol
//

/// This protocol is used to mock the service for test purposes
protocol CenterServices {
  
  func fetchCenterList(completionHandler: @escaping([CenterRegistered]) -> Void)
}
