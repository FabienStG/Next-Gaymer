//
//  NewMessageViewModel.swift
//  Next Gaymer
//
//  Created by Fabien Saint Germain on 22/01/2022.
//

import SwiftUI

class UsersAdminViewModel: ObservableObject {

  @Published var usersLimitedDetailsList = [UserDetailsAdmin]()
  
  init() {
    fetchUsersList()
  }
  
  private func fetchUsersList() {
    print("Fetch UsersList")
    DataManager.shared.fetchAllUsers { users, error in
      if let users = users {
        self.limitUsersDetails(users)
      }
    }
  }
  
  private func limitUsersDetails(_ usersList: [UserRegistered]) {
    usersList.forEach { user in
      let userLimitedDetails = UserDetailsAdmin(id: user.id, pseudo: user.pseudo, name: user.name, surname: user.surname, email: user.email, city: user.city, profileImageUrl: user.profileImageUrl, isAdmin: user.isAdmin)
      usersLimitedDetailsList.append(userLimitedDetails)
    }
  }

}
