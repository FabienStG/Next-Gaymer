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
  @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
  
  var body: some View {
    VStack {
      Form {
        HStack {
          Spacer()
          BannerPickerView(changeProfileImage: $eventCreationModel.changeBannerImage, openCameraRool: $eventCreationModel.openCameraRoll, imageSelected: $eventCreationModel.image)
          Spacer()
        }
        .listRowBackground(Color(UIColor.systemGroupedBackground))
        Section {
          TextField("Nom de l'évènement", text: $eventCreationModel.eventName)
          TextField("Bénévole(s)", text: $eventCreationModel.madeBy)
          Picker("En ligne", selection: $eventCreationModel.isOffline) {
            Text("En ligne").tag(false)
            Text("Hors ligne").tag(true)
          }
          .pickerStyle(.segmented)
        } header: {
          Text("Evènement")
        }
        if eventCreationModel.isOffline {
          Section {
            TextField("Lieu", text: $eventCreationModel.location)
            VStack {
              HStack {
                Text("min: 10")
                Spacer()
                Text("\(Int(eventCreationModel.maximumPlaces))")
                  .foregroundColor(Color("Purple"))
                Spacer()
                Text("max: 150")
              }
              Slider(value: $eventCreationModel.maximumPlaces, in: 10...150)
            }
          } header: {
            Text("Lieu et capacité")
          }
        }
        Section {
          DatePicker("Date :", selection: $eventCreationModel.date, displayedComponents: [.date])
          DatePicker("Heure de début :", selection: $eventCreationModel.startHour, displayedComponents: [.hourAndMinute])
          DatePicker("Heure de fin :", selection: $eventCreationModel.endHour, displayedComponents: [.hourAndMinute])
        } header : {
          Text("Date et heure")
        }
        Section {
          TextEditor(text: $eventCreationModel.description)
        } header: {
          Text("Description")
        }
        Button {
          eventCreationModel.showConfirmation.toggle()
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
      }
      .alert(eventCreationModel.alertMessage, isPresented: $eventCreationModel.showAlert) {}
      .confirmationDialog("Valider ?", isPresented: $eventCreationModel.showConfirmation) {
        Button(role: .cancel) {} label: {
          Text("Annuler")
        }
        Button() {
          eventCreationModel.registrateEvent()
        } label: {
          Text("Créer l'évènement")
        }
      }
    }
    .onReceive(eventCreationModel.$requestStatus) { newValue in
      if eventCreationModel.requestStatus == .success {
        self.presentationMode.wrappedValue.dismiss()
      }
    }
  }
}

struct EventCreationAdminView_Previews: PreviewProvider {
    static var previews: some View {
        EventCreationAdminView()
    }
}

