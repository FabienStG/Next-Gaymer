//
//  UserDetailsAdminView.swift
//  Next Gaymer
//
//  Created by Fabien Saint Germain on 22/01/2022.
//

import SwiftUI
import SDWebImageSwiftUI

struct UserDetailsAdminView: View {
  
  @EnvironmentObject var userAdminModel: UsersAdminViewModel
  
    var body: some View {
      VStack {
        Image(systemName: "person.fill")
        Text("Pseudo")
      }
    }
}

struct UserDetailsAdminView_Previews: PreviewProvider {
    static var previews: some View {
      UserDetailsAdminView().environmentObject(UsersAdminViewModel())
    }
}

