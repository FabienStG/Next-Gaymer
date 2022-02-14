//
//  MockedChatServices.swift
//  Next GaymerTests
//
//  Created by Fabien Saint Germain on 14/02/2022.
//

import Foundation
@testable import Next_Gaymer

class MockedChatServices: ChatServices {

  func stopChatListening() {
    return
  }
  
  func stopRecentMessageListening() {
    return
  }
  
  func fetchSpecificUser(selectedUser: String, completionHandler: @escaping (UserRegistered?, String?) -> Void) {
    return completionHandler(FakeData.registeredAdmin, nil)
  }
  
  func fetchMessages(senderUser: UserRegistered, recipientUser: UserDetails, listen: Listener) {
    listen.haveChatMessage(FakeData.chatMessage)
  }
  
  func fetchRecentMessages(currentUser: UserRegistered, listen: Listener) {
    listen.haveRecentMessage(FakeData.recentMessage)
  }
  
  func saveMessage(textMessage: String, recipientUserId: String, completionHandler: @escaping (Bool, String?) -> Void) {
    return completionHandler(true, nil)
  }
  
  func saveRecentMessage(textMessage: String, senderUser: UserRegistered, recipientUser: UserDetails, completionHandler: @escaping (Bool, String?) -> Void) {
    return completionHandler(true, nil)
  }
  
}

class MockedChatServicesFailed: ChatServices {
  func stopChatListening() {
    return
  }
  
  func stopRecentMessageListening() {
    return
  }
  
  func fetchSpecificUser(selectedUser: String, completionHandler: @escaping (UserRegistered?, String?) -> Void) {
    return completionHandler(nil, NSLocalizedString("failFindUser", comment: ""))
  }
  
  func fetchMessages(senderUser: UserRegistered, recipientUser: UserDetails, listen: Listener) {
    listen.haveError(NSLocalizedString("failFetchMessage", comment: ""))
  }
  
  func fetchRecentMessages(currentUser: UserRegistered, listen: Listener) {
    listen.haveError(NSLocalizedString("failFetchMessage", comment: ""))
  }
  
  func saveMessage(textMessage: String, recipientUserId: String, completionHandler: @escaping (Bool, String?) -> Void) {
    return completionHandler(false, "error")
  }
  
  func saveRecentMessage(textMessage: String, senderUser: UserRegistered, recipientUser: UserDetails, completionHandler: @escaping (Bool, String?) -> Void) {
    return completionHandler(false, "error")
  }
  
}

