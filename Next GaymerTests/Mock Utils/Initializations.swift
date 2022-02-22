//
//  DataManagerInit.swift
//  Next GaymerTests
//
//  Created by Fabien Saint Germain on 16/02/2022.
//

import Foundation
@testable import Next_Gaymer

struct DataManagerInit {
  
  static let success = DataManager(registrationServices: MockedRegistrationServices(), chatServices: mockedChat,
                                   eventServices: MockedEventServices(), adminServices: MockedAdminServices(),
                                   userServices: MockedUserServices(), centerServices: MockedCenterServices())
  
  static let failed = DataManager(registrationServices: MockedRegistrationServicesFailed(), chatServices: MockedChatServicesFailed(),
                                   eventServices: MockedEventServicesFailed(), adminServices: MockedAdminServicesFailed(),
                                  userServices: MockedUserServicesFailed(), centerServices: MockedCenterServicesFailed())
  
  static let mockedChat = MockedChatServices()
}


struct MapManagerInit {
  
  static let success = MapManager(mapServices: MockedMapServices())
  
  static let failed = MapManager(mapServices: MockedMapServicesFailed())
}


struct NotificationManagerInit {
  
  static let success = NotificationManager(notificationsServices: mockedNotification)
  
  static let failed = NotificationManager(notificationsServices: MockedNotificationsServicesFailed())
  
  static let mockedNotification = MockedNotificationsServices()
}


struct ViewModelsInit {
  
  static func registerProvideForm(_ vm: RegisterViewModel) {
    
    vm.password = "test"
    vm.pseudo = "test"
    vm.confirmPassword = "test"
    vm.email = "test"
    vm.city = "test"
    vm.zipCode = "test"
    vm.street = "test"
    vm.discordPseudo = "test"
    vm.phoneNumber = "test"
    vm.surname = "test"
    vm.name = "test"
  }
  
  static func googleProvideForm(_ vm: GoogleRegisterViewModel) {
    
    vm.password = "test"
    vm.pseudo = "test"
    vm.confirmPassword = "test"
    vm.city = "test"
    vm.zipCode = "test"
    vm.street = "test"
    vm.discordPseudo = "test"
    vm.surname = "test"
  }
}
