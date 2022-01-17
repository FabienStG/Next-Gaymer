//
//  ContentView.swift
//  Next Gaymer
//
//  Created by Fabien Saint Germain on 13/01/2022.
//

import SwiftUI

struct HomepageView: View {
    
    @StateObject var logoutModel = LogoutViewModel()
    @EnvironmentObject var viewRouter: ViewRouter
    
    let firebase = FirebaseService()
    
    var body: some View {
        NavigationView {
            VStack {
                Text("HomeView")
                    .navigationTitle("Next Gaymer")
                Button {
                    firebase.fetchUser()
                } label: {
                    Text("Afficher profil")
                }

            }
                .toolbar {
                    ToolbarItem(placement: .navigationBarTrailing) {
                        if logoutModel.processing  {
                            ProgressView()
                        } else {
                        Button("Se déconnecter") {
                            logoutModel.logoutUser { result in
                                withAnimation {
                                    viewRouter.currentPage = .loggedOut
                                }
                            }
                        }
                      }
                    }
                }
                .alert(logoutModel.errorMessage, isPresented: $logoutModel.showAlert) {}
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        HomepageView()
    }
}
