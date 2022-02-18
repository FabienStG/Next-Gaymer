//
//  Listener.swift
//  Next Gaymer
//
//  Created by Fabien Saint Germain on 01/02/2022.
//

import Foundation
//
// MARK: - Listener Protocol
//

/// Protocol for ViewModels to provide the live update of chatMessage
protocol Listener {
  
  func haveChatMessage(_ message: ChatMessage)
  func haveRecentMessage(_ message: RecentMessage)
  func haveError(_ errorMessage: String)
  func stopListening()
  
}
