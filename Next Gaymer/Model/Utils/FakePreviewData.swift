//
//  PreviewFakeData.swift
//  Next Gaymer
//
//  Created by Fabien Saint Germain on 26/01/2022.
//

import MapKit
//
// MARK: - FakePreview Data
//

/// Class used to mock some firebase data
/// Used to pass into the SwiftUI previews parameters
class FakePreviewData {
  //
  // MARK: - Private constant
  //
  private static let image = "https://d5nunyagcicgy.cloudfront.net/external_assets/hero_examples/hair_beach_v391182663/original.jpeg"
  private static let eventImage = "https://firebasestorage.googleapis.com:443/v0/b/nextgaymer.appspot.com/o/389D1BFB-6E8B-4366-B009-7FF2AA25DF7C?alt=media&token=a0f8e632-1814-4fc1-a029-ee75babb8cb7"
  
  private static let fakeRegisteredAdmin = UserRegistered(id: "9Hkh3HUKCwh1o3gE1cLLJRmLQQf2", name: "Fabien", surname: "Saint Germain",
                                                          pseudo: "Damnes", profileImageUrl: image, email: "fabien@icloud.com",
                                                          phoneNumber: "0123456789", discordPseudo: "Damnes",
                                                          street: "01 rue de la paix", zipCode: "75001", city: "Paris", isAdmin: true, myEvent: [])
  
  private static let fakeRegisteredUser = UserRegistered(id: "LEoXQsTtXcNdaiHoUlcmX6I0PsO2", name: "Michel", surname: "Delpomme",
                                                         pseudo: "Miche", profileImageUrl: image, email: "miche@icloud.com",
                                                         phoneNumber: "0123456789", discordPseudo: "Miche", street: "01 rue de la paix",
                                                         zipCode: "75001", city: "Paris", isAdmin: false, myEvent: [])
  
  //
  // MARK: - Usable static constant
  //
  static let selectedUser = SelectedUserViewModel(selectedUser: FakePreviewData.fakeSelectedUser)
  
  static let fakeLocation = Location(name: "Centre LGBTQI+ de Paris et d'Île-de-France",adress: "63 rue Beaubourg, 75003 Paris",
                                     phoneNumber: "01 43 57 21 47", coordinate: CLLocationCoordinate2D(latitude: 48.86323051489019, longitude: 2.3542835693817454))
  
  static let fakeSelectedUser = UserDetails(id: "GbuydisSe5ZLo4W5gpodtwozZl62", pseudo: "Maryël", name: "Marie",
                                            surname: "Hel", email: "mariel@icloud.com", city: "Paris",
                                            profileImageUrl: image, isAdmin: false)
  
  static let fakeOnlineEvent = EventCreated(id: "fakeID", imageUrl: eventImage, eventName: "Nom de l'évènement",
                                            isOffline: false, date: Date(), location: "14 rue mahcin",
                                            town: "", madeBy: "Damnes", description: "Description", maximumPlaces: 0, takenPlaces: 0,
                                            registrant: [fakeSelectedUser])
  
  static let fakeOfflineEvent = EventCreated(id: "fakeID", imageUrl: eventImage, eventName: "Nom de l'évènement",
                                            isOffline: true, date: Date(), location: "14 rue mahcin",
                                            town: "Paris", madeBy: "Damnes", description: "Description", maximumPlaces: 50, takenPlaces: 20,
                                            registrant: [fakeSelectedUser])
  
  static let fakeRecentMessage = RecentMessage(id: "fakeId", text: "Hey salut !", senderUserId: "Fakeid", recipientUserId: "otherFake",
                                               timestamp: Date(), profileImageUrl: image, pseudo: "Damnes", isAdmin: false)
  
  static let helpCenter = HelpCenter(id: "idtest", name: "SOShomophobie", phoneNumber: "0148064241", phoneNumberURL: URL(string: "tel://0148064241")!, url: URL(string: "https://www.sos-homophobie.org")!, description: "sosHomophobieDescription")
  
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
}
