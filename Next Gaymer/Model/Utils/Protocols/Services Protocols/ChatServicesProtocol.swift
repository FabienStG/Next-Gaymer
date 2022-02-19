//
//  ChatServicesProtocol.swift
//  Next Gaymer
//
//  Created by Fabien Saint Germain on 14/02/2022.
//

import Foundation
//
// MARK: - Chat Services Protocol
//

/// This protocol help for the firebase mocking tests
protocol ChatServices {

  func stopChatListening()

  func stopRecentMessageListening()
  
  func fetchSpecificUser(selectedUser: String, completionHandler: @escaping(UserRegistered?, String?) -> Void)
  
  func fetchMessages(senderUser: UserRegistered, recipientUser: UserDetails, listen: Listener)
  
  func fetchRecentMessages(currentUser: UserRegistered, listen: Listener)
  
  func saveMessage(textMessage: String, recipientUserId: String, completionHandler: @escaping(Bool, String?) -> Void)
  
  func saveRecentMessage(textMessage: String, senderUser: UserRegistered, recipientUser: UserDetails, completionHandler: @escaping(Bool, String?) -> Void)
}
