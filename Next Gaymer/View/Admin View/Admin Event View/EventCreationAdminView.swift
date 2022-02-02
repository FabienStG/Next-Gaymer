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
          TextField(NSLocalizedString("eventName", comment: ""), text: $eventCreationModel.eventName)
          TextField(NSLocalizedString("volunter", comment: ""), text: $eventCreationModel.madeBy)
          Picker("isOnline", selection: $eventCreationModel.isOffline) {
            Text(NSLocalizedString("online", comment: "")).tag(false)
            Text(NSLocalizedString("offline", comment: "")).tag(true)
          }
          .pickerStyle(.segmented)
        } header: {
          Text(NSLocalizedString("event", comment: ""))
        }
        if eventCreationModel.isOffline {
          Section {
            TextField(NSLocalizedString("place", comment: ""), text: $eventCreationModel.location)
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
            Text(NSLocalizedString("placeCapacity", comment: ""))
          }
        }
        Section {
          DatePicker("Date :", selection: $eventCreationModel.date, displayedComponents: [.date])
          DatePicker(NSLocalizedString("startHour", comment: ""), selection: $eventCreationModel.startHour, displayedComponents: [.hourAndMinute])
          DatePicker(NSLocalizedString("endHour", comment: ""), selection: $eventCreationModel.endHour, displayedComponents: [.hourAndMinute])
        } header : {
          Text(NSLocalizedString("dateTime", comment: ""))
        }
        Section {
          TextEditor(text: $eventCreationModel.description)
        } header: {
          Text("Description")
        }
        Button {
          eventCreationModel.showConfirmation.toggle()
        } label: {
          Text(NSLocalizedString("createEvent", comment: ""))
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
      .confirmationDialog(NSLocalizedString("confirm", comment: "") + " ?", isPresented: $eventCreationModel.showConfirmation) {
        Button(role: .cancel) {} label: {
          Text(NSLocalizedString("cancel", comment: ""))
        }
        Button() {
          eventCreationModel.registrateEvent()
        } label: {
          Text(NSLocalizedString("createEvent", comment: ""))
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

