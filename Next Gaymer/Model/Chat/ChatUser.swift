//
//  ChatUser.swift
//  Next Gaymer
//
//  Created by Fabien Saint Germain on 24/01/2022.
//

import Foundation
import FirebaseFirestoreSwift

struct ChatUser: Codable, Identifiable {
  
  @DocumentID var id: String?
  
  let userId: String
  let pseudo: String
  let profileImageUrl: String
}
