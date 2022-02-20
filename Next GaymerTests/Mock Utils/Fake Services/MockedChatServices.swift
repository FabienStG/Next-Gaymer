//
//  MockedChatServices.swift
//  Next GaymerTests
//
//  Created by Fabien Saint Germain on 14/02/2022.
//

import Foundation
@testable import Next_Gaymer

class MockedChatServices: ChatServices {

  var didFunctionCalled = false
  
  func stopChatListening() {
    didFunctionCalled = true
  }
  
  func stopRecentMessageListening() {
    didFunctionCalled = true
  }
  
  func fetchSpecificUser(selectedUser: String, completionHandler: @escaping (UserRegistered?, String?) -> Void) {
    return completionHandler(FakeData.registeredAdmin, nil)
  }
  
  func fetchMessages(senderUser: UserRegistered, recipientUser: UserDetails, listen: Listener) {
    listen.haveChatMessage(FakeData.chatMessage)
  }
  
  func fetchRecentMessages(listen: Listener) {
    listen.haveRecentMessage(FakeData.recentMessage)
  }
  
  func saveMessage(textMessage: String, recipientUserId: String, completionHandler: @escaping (Bool, String?) -> Void) {
    return completionHandler(true, nil)
  }
  
  func saveRecentMessage(textMessage: String, senderUser: UserRegistered, recipientUser: UserDetails, completionHandler: @escaping (Bool, String?) -> Void) {
    return completionHandler(true, nil)
  }
  
  func deleteRecentMessage(message: RecentMessage) {
    didFunctionCalled = true
  }  
}

class MockedChatServicesFailed: ChatServices {
  func stopChatListening() {}
  
  func stopRecentMessageListening() {}
  
  func fetchSpecificUser(selectedUser: String, completionHandler: @escaping (UserRegistered?, String?) -> Void) {
    return completionHandler(nil, NSLocalizedString("failFindUser", comment: ""))
  }
  
  func fetchMessages(senderUser: UserRegistered, recipientUser: UserDetails, listen: Listener) {
    listen.haveError(NSLocalizedString("failFetchMessage", comment: ""))
  }
  
  func fetchRecentMessages(listen: Listener) {
    listen.haveError(NSLocalizedString("failFetchMessage", comment: ""))
  }
  
  func saveMessage(textMessage: String, recipientUserId: String, completionHandler: @escaping (Bool, String?) -> Void) {
    return completionHandler(false, "error")
  }
  
  func saveRecentMessage(textMessage: String, senderUser: UserRegistered, recipientUser: UserDetails, completionHandler: @escaping (Bool, String?) -> Void) {
    return completionHandler(false, "error")
  }
  
  func deleteRecentMessage(message: RecentMessage) {}
}

