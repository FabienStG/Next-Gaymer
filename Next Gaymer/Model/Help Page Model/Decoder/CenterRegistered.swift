//
//  HelpCenter.swift
//  Next Gaymer
//
//  Created by Fabien Saint Germain on 20/02/2022.
//

import Foundation
import FirebaseFirestoreSwift
//
// MARK: - HelpCenter
//

/// This struc is the one stored in Firebase for the help centers
struct CenterRegistered: Codable, Identifiable {
  
  @DocumentID var id: String?
  
  let name: String
  let phoneNumber: String
  let url: String
  let en: String
  let fr: String
}
