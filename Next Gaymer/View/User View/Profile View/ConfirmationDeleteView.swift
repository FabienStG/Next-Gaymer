//
//  ReauthenticateView.swift
//  Next Gaymer
//
//  Created by Fabien Saint Germain on 19/02/2022.
//

import SwiftUI

struct ConfirmationDeleteView: View {
  
  @StateObject var confirmationDeleteModel = ConfirmationDeleteViewModel()
  
  @Environment(\.presentationMode) var presentationMode
  @EnvironmentObject var viewRouter: ViewRouter

  var body: some View {
    VStack {
      
      Text(NSLocalizedString("warningDelete", comment: ""))
        .font(.title2)
        .foregroundColor(.red)
        .fontWeight(.bold)
        .padding()
      Group {
        TextField("Email", text: $confirmationDeleteModel.email)
          .disableAutocorrection(true)
          .autocapitalization(.none)
          .padding()
        SecureField(NSLocalizedString("password", comment: ""),
                  text: $confirmationDeleteModel.password)
          .padding()
      }
      Button {
        confirmationDeleteModel.reauthenticateUser()
      } label: {
        ButtonTextView(status: $confirmationDeleteModel.requestStatus, text: NSLocalizedString("confirmDelete", comment: ""))
      }
      .padding()
    }
    .onReceive(confirmationDeleteModel.$requestStatus) { newValue in
      if newValue == .success {
        viewRouter.currentPage = .loggedOut
        presentationMode.wrappedValue.dismiss()
      }
    }
  }
}

struct ProfileManagementView_Previews: PreviewProvider {
  static var previews: some View {
    ConfirmationDeleteView().environmentObject(ProfileViewModel()).environmentObject(ViewRouter())
  }
}
