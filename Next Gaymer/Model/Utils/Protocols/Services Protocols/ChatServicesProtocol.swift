//
//  ChatServicesProtocol.swift
//  Next Gaymer
//
//  Created by Fabien Saint Germain on 14/02/2022.
//

import Foundation

protocol ChatServices {
  /// Remove the firebase listener to stop the automatic query from the live chat page
  func stopChatListening()
  
  /// Remove the firebase listener to stop the automatic query from the recent message page
  func stopRecentMessageListening()
  
  /// Fetch a user with his Id and return the document as an object
  func fetchSpecificUser(selectedUser: String, completionHandler: @escaping(UserRegistered?, String?) -> Void)
  
  /// Fetch the messages registered in firestore and put a firestore listener to update automaticly when any message is send, throught the protocol
  func fetchMessages(senderUser: UserRegistered, recipientUser: UserDetails, listen: Listener)
  
  /// Fetch all the recents messages sent for the main message page, and put a firestore listener to update automaticly when any message is send, throught the protocol
  func fetchRecentMessages(currentUser: UserRegistered, listen: Listener)
  
  /// Save a message as a chat message in firestore in two versions, one for the sender, one for the recipient
  func saveMessage(textMessage: String, recipientUserId: String, completionHandler: @escaping(Bool, String?) -> Void)
  
  /// Save a message as a recent message object in firestore in two versions, one for the sender and one for the recipient
  func saveRecentMessage(textMessage: String, senderUser: UserRegistered, recipientUser: UserDetails, completionHandler: @escaping(Bool, String?) -> Void)
}
