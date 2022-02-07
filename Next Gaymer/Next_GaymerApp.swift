//
//  Next_GaymerApp.swift
//  Next Gaymer
//
//  Created by Fabien Saint Germain on 13/01/2022.
//

import SwiftUI
import Firebase
//
// MARK: - Next Gaymer APP
//
@main
struct Next_GaymerApp: App {
  //
  // MARK: - App Delegate Adaptator
  //
  /// As swiftUI have not app delegate anymore, this help to provide one
  @UIApplicationDelegateAdaptor(AppDelegate.self) var delegate

  //
  // MARK: - State Object
  //
  /// This is the initialization of the view routers
  @StateObject var viewRouter = ViewRouter()
  @StateObject var tabBarRouter = TabBarRouter()
  
  //
  // MARK: - Initialization
  //
  init() {
    FirebaseApp.configure()
    /// If the selected schema is Emulator, then all the firebase function will be stored local thanks to an emulator
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
