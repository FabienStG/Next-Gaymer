//
//  UserDetailsAdminView.swift
//  Next Gaymer
//
//  Created by Fabien Saint Germain on 22/01/2022.
//

import SwiftUI
import SDWebImageSwiftUI

struct UserDetailsAdminView: View {
  
  @StateObject var userDetails: UserDetailsAdminViewModel
  
    var body: some View {
      VStack {
        WebImage(url: URL(string: userDetails.selectedUser.profileImageUrl) )
          .resizable()
          .scaledToFill()
          .frame(width:150, height: 150)
          .clipped()
          .cornerRadius(75)
          .overlay(RoundedRectangle(cornerRadius: 75)
                    .stroke(Color("Purple"), lineWidth: 4))
        Text(userDetails.selectedUser.pseudo)
          .padding()
        VStack(alignment: .leading) {
          Spacer()
          Text(userDetails.selectedUser.name)
            .padding()
          Text(userDetails.selectedUser.surname)
            .padding()
          Text(userDetails.selectedUser.email)
            .padding()
          Text(userDetails.selectedUser.city)
            .padding()

          Spacer()
        }
        .padding()
        .frame(maxWidth: .infinity, alignment: .leading)
        NavigationLink {
          withAnimation {
            ChatLogAdminView(selectedUser: SelectedUserViewModel(selectedUser: userDetails.selectedUser))
          }
        } label: {
            Text("Envoyer un Message")
          }
          .padding()
          .foregroundColor(.white)
          .background(Color.blue)
          .cornerRadius(10)
          .navigationTitle("Profil")
          .navigationBarTitleDisplayMode(.inline)
        if !userDetails.selectedUser.isAdmin {
          Divider()
          Button {
            userDetails.presentConfirmation.toggle()
          } label: {
            Text("Passer Administrateur")
              .foregroundColor(.red)
          }
          .padding()
        }
      }
      .alert(userDetails.confirmationMessage, isPresented: $userDetails.presentAlert) {}
      .confirmationDialog("Valider ?", isPresented: $userDetails.presentConfirmation) {
        Button(role: .cancel) {} label: {
          Text("Annuler")
        }
        Button(role: .destructive) {
          userDetails.setUserAdminCrentials()
        } label: {
          Text("Valider l'accès Administrateur")
        }
      }
    }
}

struct UserDetailsAdminView_Previews: PreviewProvider {
    static var previews: some View {
      UserDetailsAdminView(userDetails: UserDetailsAdminViewModel(selectedUser: UserDetails(id: "FakeID", pseudo: "Pseudo", name: "Prénom", surname: "Nom", email: "email", city: "Ville", profileImageUrl: "https://d5nunyagcicgy.cloudfront.net/external_assets/hero_examples/hair_beach_v391182663/original.jpeg", isAdmin: false)))
    }
}

