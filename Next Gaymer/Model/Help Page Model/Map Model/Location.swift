//
//  Location.swift
//  Next Gaymer
//
//  Created by Fabien Saint Germain on 26/01/2022.
//
import MapKit
//
// MARK: - Location
//

/// Struct used to store the pinned locations into MapKit
struct Location: Identifiable {

  let id = UUID()
  let name: String
  let adress: String
  let phoneNumber: String
  let coordinate: CLLocationCoordinate2D
}

//
// MARK: - Locations
//

/// Stock the array of locations showed in Mapkit
struct Locations {
  //
  // MARK: - Constant
  //
  static let annotations = [
  Location(name: "Centre LGBTQI+ de Paris et d'Île-de-France",adress: "63 rue Beaubourg, 75003 Paris", phoneNumber: "01 43 57 21 47",
           coordinate: CLLocationCoordinate2D(latitude: 48.86323051489019, longitude: 2.3542835693817454)),

  Location(name: "Centre LGBTI de Touraine", adress: "11bis rue des Tanneurs, 37000 Tours", phoneNumber: "02 47 54 24 79",
           coordinate: CLLocationCoordinate2D(latitude: 47.395955669575955, longitude: 0.6794920846214466)),

  Location(name: "Centre LGBTI de Normandie", adress: "22 rue du Général Giraud, 14000 Caen", phoneNumber: "02 31 74 50 46",
           coordinate: CLLocationCoordinate2D(latitude: 48.07151413728261, longitude: 0.18245101425287186)),

  Location(name: "Centre LGBTI de Grenoble", adress: "8 rue du Sergent Bobillot, 38000 Grenoble", phoneNumber: "",
           coordinate: CLLocationCoordinate2D(latitude: 48.07151413728261, longitude: 0.18245101425287186)),

  Location(name: "Centre LGBTI+ Le Girofard", adress: "34 rue Bouquière, 33000 Bordeaux", phoneNumber: "09 54 19 65 04",
           coordinate: CLLocationCoordinate2D(latitude: 44.836741791356225, longitude: -0.5702583038001693)),

  Location(name: "Centre LGBTI+ de Lyon", adress: "19 rue des Capucins, 69001 Lyon", phoneNumber: "08 05 03 11 81",
           coordinate: CLLocationCoordinate2D(latitude: 45.76962649160783, longitude: 4.834403798071487)),

  Location(name: "SOS Homophobie", adress: "14 rue Aben, 75012 Paris", phoneNumber: "01 48 06 42 41",
           coordinate: CLLocationCoordinate2D(latitude: 48.84774690343618, longitude: 2.375713184661937)),

  Location(name: "AIDES", adress: "20 rue de Moscou, 75008 Paris", phoneNumber: "09 53 16 50 25",
           coordinate: CLLocationCoordinate2D(latitude: 48.92310194876069, longitude: 2.261727073024054))

  ]
}

//
// MARK: - MapDetails
//

/// An enum used to give standard parameters for location and spin
enum MapDetails {
  
  static let defaultLocation = CLLocationCoordinate2D(latitude: 46.227638, longitude: 2.213749)
  static let defaultSpin = MKCoordinateSpan(latitudeDelta: 11, longitudeDelta: 11)
  static let zoomedSpin = MKCoordinateSpan(latitudeDelta: 0.05, longitudeDelta: 0.05)
}

//
// MARK: - CLLocation Coordinate 2D Extention
//

/// Used to provide more easily the coordinate info
extension CLLocationCoordinate2D: Identifiable {
  
  public var id: String {
    "\(latitude)-\(longitude)"
  }
}
