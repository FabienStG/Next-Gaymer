//
//  EventCreationAdminView.swift
//  Next Gaymer
//
//  Created by Fabien Saint Germain on 24/01/2022.
//

import SwiftUI
import SDWebImageSwiftUI

struct EventCreationAdminView: View {
  
  @StateObject var eventCreationModel = EventRegisterAdminViewModel()
  
    var body: some View {

      VStack {
        Form {
          BannerPickerView(changeProfileImage: $eventCreationModel.changeBannerImage, openCameraRool: $eventCreationModel.openCameraRoll, imageSelected: $eventCreationModel.image)
            .listRowBackground(Color(UIColor.systemGroupedBackground))
          Section {
            TextField("Nom de l'évènement", text: $eventCreationModel.eventName)
            TextField("Organisateur(s)", text: $eventCreationModel.madeBy)
            Picker("En ligne", selection: $eventCreationModel.isOffline) {
              Text("En ligne")
              Text("Hors ligne")
            }
            .pickerStyle(.segmented)
            DatePicker("Date", selection: $eventCreationModel.date)
          } header: {
            Text("Evènement")
          }
          Section {
            TextEditor(text: $eventCreationModel.shortDescription)
          } header: {
            Text("Résumé")
          }

          Section {
            TextEditor(text: $eventCreationModel.longDescription)
          } header: {
            Text("Description")
          }
          Button {
            eventCreationModel.registrateEvent()
          } label: {
            Text("Valider la création")
              .font(.title3)
              .foregroundColor(.white)
              .multilineTextAlignment(.center)
              .padding()
              .frame(width: 200, height: 46)
              .background(Color.blue)
              .cornerRadius(15.0)
            
          }
          .frame(maxWidth: .infinity, alignment: .center)
          .listRowBackground(Color(UIColor.systemGroupedBackground))
          .disabled(eventCreationModel.disableButton())
        }

        .alert(eventCreationModel.alertMessage, isPresented: $eventCreationModel.showAlert) {}
      }
    }
    
}

struct EventCreationAdminView_Previews: PreviewProvider {
    static var previews: some View {
        EventCreationAdminView()
    }
}

