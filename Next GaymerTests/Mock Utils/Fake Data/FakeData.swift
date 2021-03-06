//
//  FakeData.swift
//  Next GaymerTests
//
//  Created by Fabien Saint Germain on 14/02/2022.
//

import MapKit
@testable import Next_Gaymer

class FakeData {

  static let image = "imageURL"
  
  static let registeredAdmin = UserRegistered(id: "9Hkh3HUKCwh1o3gE1cLLJRmLQQf2", name: "Fabien", surname: "Saint Germain",
                                                          pseudo: "Damnes", profileImageUrl: image, email: "fabien@icloud.com",
                                                          phoneNumber: "0123456789", discordPseudo: "Damnes",
                                                          street: "01 rue de la paix", zipCode: "75001", city: "Paris", isAdmin: true, myEvent: [])
  
  static let registeredUser = UserRegistered(id: "LEoXQsTtXcNdaiHoUlcmX6I0PsO2", name: "Michel", surname: "Delpomme",
                                                         pseudo: "Miche", profileImageUrl: image, email: "miche@icloud.com",
                                                         phoneNumber: "0123456789", discordPseudo: "Miche", street: "01 rue de la paix",
                                                         zipCode: "75001", city: "Paris", isAdmin: false, myEvent: [])
  
  static let allRegisteredUsers = [registeredUser, registeredAdmin]
  
  static let chatMessage = ChatMessage(id: "id", senderUserId: "9Hkh3HUKCwh1o3gE1cLLJRmLQQf2",
                                       recipientUserId: "LEoXQsTtXcNdaiHoUlcmX6I0PsO2", text: "Test Message",
                                       timestamp: Date())

  static let userDetails = UserDetails(id: "GbuydisSe5ZLo4W5gpodtwozZl62", pseudo: "Maryël", name: "Marie",
                                       surname: "Hel", email: "mariel@icloud.com", city: "Paris",
                                       profileImageUrl: image, isAdmin: false)
  
  static let adminDetails = UserDetails(id: "9Hkh3HUKCwh1o3gE1cLLJRmLQQf2", pseudo: "Damnes", name: "Name",
                                        surname: "Surname", email: "email", city: "city",
                                        profileImageUrl: image, isAdmin: true)
  
  static let userForm = UserForm(name: "Prénom", surname: "Nom", pseudo: "Pseudo", email: "mail", phoneNumber: "phone",
                                 discordPseudo: "Pseudo", street: "street", zipCode: "0000", city: "city")
  
  
  static let eventWithRegisters = EventCreated(id: "fakeID", imageUrl: image, eventName: "Nom de l'évènement",
                                               isOffline: false, date: Date(), location: "14 rue mahcin",
                                               town: "Paris", madeBy: "Damnes", description: "Description", maximumPlaces: 4, takenPlaces: 0,
                                               registrant: [userDetails, adminDetails])
  
  static let eventWithNoRegisters = EventCreated(id: "fakeID", imageUrl: image, eventName: "Nom de l'évènement",
                                                 isOffline: false, date: Date(), location: "14 rue mahcin",
                                                 town: "Paris", madeBy: "Damnes", description: "Description", maximumPlaces: 0, takenPlaces: 0,
                                                 registrant: [])
  
  static let eventWithFullRegisters = EventCreated(id: "fakeID", imageUrl: image, eventName: "Nom de l'évènement",
                                                   isOffline: false, date: Date(), location: "14 rue mahcin",
                                                   town: "Paris", madeBy: "Damnes", description: "Description", maximumPlaces: 2, takenPlaces: 2,
                                                   registrant: [userDetails, adminDetails])
  
  static let recentMessage = RecentMessage(id: "fakeId", text: "Hey salut !", senderUserId: "Fakeid", recipientUserId: "otherFake",
                                           timestamp: Date(), profileImageUrl: image, pseudo: "Damnes", isAdmin: false)
  
  static let eventForm = EventForm(eventName: "Event", isOffline: false, date: Date(),
                                   location: "Location", town: "Town", madeBy: "MadeBy",
                                   description: "Description", maximumPlaces: 1)
  
  static let uiImage = UIImage(systemName: "plus")
  
  static let centerArray = [CenterRegistered(id: "fakeId", name: "SOShomophobie", phoneNumber: "0148064241", url: "https://www.sos-homophobie.org", en: "sosHomophobieDescription", fr: "sosHomophobieFr")]
  
  
  static let selectedUser = SelectedUserViewModel(selectedUser: FakePreviewData.fakeSelectedUser)
  
  static var currentAdminUser: CurrentUserViewModel {
    
    let fakeUser = CurrentUserViewModel()
    fakeUser.currentUser = FakeData.registeredAdmin
    return fakeUser
  }
  
  static var currentUser: CurrentUserViewModel {
    
    let fakeUser = CurrentUserViewModel()
    fakeUser.currentUser = FakeData.registeredUser
    return fakeUser
  }
  
  static let defaultLocation = CLLocationCoordinate2D(latitude: 30.227638, longitude: 15.213749)
  static let defaultSpin = MKCoordinateSpan(latitudeDelta: 5, longitudeDelta: 5)
  
  static let userLocation = CLLocationCoordinate2D(latitude: 46.227638, longitude: 2.213749)
  static let userSpin = MKCoordinateSpan(latitudeDelta: 11, longitudeDelta: 11)
}
