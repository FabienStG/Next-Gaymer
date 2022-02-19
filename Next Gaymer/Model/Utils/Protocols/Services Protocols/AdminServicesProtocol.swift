//
//  AdminServicesProtocol.swift
//  Next Gaymer
//
//  Created by Fabien Saint Germain on 14/02/2022.
//

import Foundation
//
// MARK: - Admin Services Protocol
//

/// This protocol help for the firebase mocking tests
protocol AdminServices {

  func setUserAdminCredentials(userId: String, completionHandler: @escaping(String) -> Void)
  
  func fetchAllUsers(successHandler: @escaping ([UserRegistered]) -> Void, errorHandler: @escaping(String) -> Void)

  func fetchEventRegistrants(event: EventCreated, successHandler: @escaping([UserDetails]) -> Void, errorHandler: @escaping(String) -> Void)
}
