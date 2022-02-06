//
//  Next_GaymerApp.swift
//  Next Gaymer
//
//  Created by Fabien Saint Germain on 13/01/2022.
//

import SwiftUI
import Firebase
import FirebaseAuth
import FirebaseStorage

@main
struct Next_GaymerApp: App {

  @UIApplicationDelegateAdaptor(AppDelegate.self) var delegate

  @StateObject var viewRouter = ViewRouter()
  @StateObject var tabBarRouter = TabBarRouter()
  
  init() {
    FirebaseApp.configure()
  #if EMULATOR
    print(DebugConstant.emulator)
    Auth.auth().useEmulator(withHost: "localhost", port: 9099)
    Storage.storage().useEmulator(withHost: "localhost", port: 9199)
    let settings = Firestore.firestore().settings
    settings.host = "localhost:8080"
    settings.isPersistenceEnabled = false
    settings.isSSLEnabled = false
    Firestore.firestore().settings = settings
  #elseif DEBUG
    print(DebugConstant.debug)
  #endif
  }

  var body: some Scene {
    WindowGroup {
      MotherView().environmentObject(viewRouter).environmentObject(tabBarRouter)
    }
  }
}
