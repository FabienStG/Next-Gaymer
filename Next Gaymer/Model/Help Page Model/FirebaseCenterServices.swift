//
//  FirebaseCenterServices.swift
//  Next Gaymer
//
//  Created by Fabien Saint Germain on 22/02/2022.
//

import Foundation
import Firebase
//
// MARK: - Firebase HelpCenters Services
//

/// This class manage the calls with firebase for the display of help centers
class FirebaseCenterServices: CenterServices {
  //
  // MARK: - Private Constant
  //
  private let db = Firestore.firestore()
  
  //
  // MARK: - Internal Methods
  //
  /// This function feth all the document in the collection in center and return array
  func fetchCenterList(completionHandler: @escaping([CenterRegistered]) -> Void) {
    
    var returnArray = [CenterRegistered]()
    db.collection(CenterConstant.helpCenter).getDocuments { snapshot, error in
      
      guard let snapshot = snapshot else { return }
      for document in snapshot.documents {
        
        let center = try? document.data(as: CenterRegistered.self)
        if let center = center {
          returnArray.append(center)
        }
      }
      return completionHandler(returnArray)
    }
  }
}
