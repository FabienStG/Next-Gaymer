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

/// This struc create the object used for display information about help centers
struct CenterRegistered: Codable, Identifiable {
  
  @DocumentID var id: String?
  
  let name: String
  let phoneNumber: String
  let url: String
  let en: String
  let fr: String
}

//
// MARK: - HelpCenters
//

/// this struc provide the array with all the help centers
/*struct HelpCenters {
  
  let centersList: [HelpCenter] = [
    
    HelpCenter(name: "SOShomophobie", phoneNumber: "0148064241", phoneNumberURL: URL(string: "tel://0148064241")!, url: URL(string: "https://www.sos-homophobie.org")!, description: NSLocalizedString("sosHomophobieDescription", comment: "")),
    
    HelpCenter(name: "RAVAD", phoneNumber: "0617551755", phoneNumberURL: URL(string: "tel://0617551755")!, url: URL(string: "https://ravad.org")!, description: NSLocalizedString("ravadDescription", comment: "")),
    
    HelpCenter(name: "Le Refuge", phoneNumber: "0631596950", phoneNumberURL: URL(string: "tel://0631596950")!, url: URL(string: "https://le-refuge.org")!, description: NSLocalizedString("leRefugeDescription", comment: "")),
    
    HelpCenter(name: "Prevention Suicide", phoneNumber: "3114", phoneNumberURL: URL(string: "tel://3114")!, url: URL(string: "https://3114.fr")!, description: NSLocalizedString("preventionSuicideDescription", comment: ""))
  ]
}
*/
