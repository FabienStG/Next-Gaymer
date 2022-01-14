//
//  ResetPasswordView.swift
//  Next Gaymer
//
//  Created by Fabien Saint Germain on 14/01/2022.
//

import SwiftUI

struct ResetPasswordView: View {
    
    @StateObject var resetPasswordModel = ResetPasswordViewModel()
    var body: some View {
        VStack(spacing: 15) {
            LogoView()
            Spacer()
            Text("Entrez le mail associé au compte")
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding()
            EmailView(email: $resetPasswordModel.email)
            Button {
                resetPasswordModel.resetPassword()
            } label : {
                ButtonTextView(bool: $resetPasswordModel.processing, text: "Envoyer un mail")
            }
            Spacer()
        }
        .padding()
        .alert(resetPasswordModel.errorMessage, isPresented: $resetPasswordModel.showAlert) {}
    }
}

struct ResetPasswordView_Previews: PreviewProvider {
    static var previews: some View {
        ResetPasswordView()
    }
}
