//
//  PreviewFakeData.swift
//  Next Gaymer
//
//  Created by Fabien Saint Germain on 26/01/2022.
//

import MapKit

class FakePreviewData {
  
  static let fakeLocation = Location(name: "Centre LGBTQI+ de Paris et d'Île-de-France",adress: "63 rue Beaubourg, 75003 Paris", phoneNumber: "01 43 57 21 47", coordinate: CLLocationCoordinate2D(latitude: 48.86323051489019, longitude: 2.3542835693817454))
  
  static var currentAdminUser: CurrentUserViewModel {
    
    let fakeUser = CurrentUserViewModel()
    fakeUser.currentUser = FakePreviewData.fakeRegisteredAdmin
    return fakeUser
  }
  
  static var currentUser: CurrentUserViewModel {
    
    let fakeUser = CurrentUserViewModel()
    fakeUser.currentUser = FakePreviewData.fakeRegisteredUser
    return fakeUser
  }
  
  static let selectedUser = SelectedUserViewModel(selectedUser: FakePreviewData.fakeSelectedUser)
  
  private static let fakeRegisteredAdmin = UserRegistered(id: "9Hkh3HUKCwh1o3gE1cLLJRmLQQf2", name: "Fabien", surname: "Saint Germain", pseudo: "Damnes", profileImageUrl: FakePreviewData.image, email: "fabien@icloud.com", phoneNumber: "0123456789", discordPseudo: "Damnes", street: "01 rue de la paix", zipCode: "75001", city: "Paris", isAdmin: true)
  
  private static let fakeRegisteredUser = UserRegistered(id: "LEoXQsTtXcNdaiHoUlcmX6I0PsO2", name: "Michel", surname: "Delpomme", pseudo: "Miche", profileImageUrl: FakePreviewData.image, email: "miche@icloud.com", phoneNumber: "0123456789", discordPseudo: "Miche", street: "01 rue de la paix", zipCode: "75001", city: "Paris", isAdmin: false)
  
  private static let fakeSelectedUser = UserDetails(id: "GbuydisSe5ZLo4W5gpodtwozZl62", pseudo: "Maryël", name: "Marie", surname: "Hel", email: "mariel@icloud.com", city: "Paris", profileImageUrl: FakePreviewData.image, isAdmin: false)
  
  private static let image = "https://d5nunyagcicgy.cloudfront.net/external_assets/hero_examples/hair_beach_v391182663/original.jpeg"
}
