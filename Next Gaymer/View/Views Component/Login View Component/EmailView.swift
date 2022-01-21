//
//  EmailView.swift
//  Next Gaymer
//
//  Created by Fabien Saint Germain on 14/01/2022.
//

import SwiftUI

struct EmailView: View {

  @Binding var email: String

  var body: some View {
    TextField("Email", text: $email)
      .padding()
      .textInputAutocapitalization(.never)
      .keyboardType(.emailAddress)
      .disableAutocorrection(true)
      .background(.thinMaterial)
      .cornerRadius(10)
    }
  }

struct EmailView_Previews: PreviewProvider {
  static var previews: some View {
    EmailView(email: .constant(""))
    }
}
