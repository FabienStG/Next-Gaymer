//
//  MapView.swift
//  Next Gaymer
//
//  Created by Fabien Saint Germain on 24/01/2022.
//

import SwiftUI
import MapKit

struct MapView: View {
  
  @StateObject var mapModel = MapViewModel()
  
    var body: some View {
      Map(coordinateRegion: $mapModel.region, showsUserLocation: true, annotationItems: mapModel.locations) { annotation in
        MapAnnotation(coordinate: annotation.coordinate) {
          PlaceAnnotationView(location: annotation)
        }
      }
        .ignoresSafeArea()
        .tint(Color("Purple"))
        .onAppear {
          mapModel.checkIfLocationServicesIsEnabled()
        }
    }
}

struct MapView_Previews: PreviewProvider {
    static var previews: some View {
        MapView()
    }
}
