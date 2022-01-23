//
//  NewMessageViewModel.swift
//  Next Gaymer
//
//  Created by Fabien Saint Germain on 22/01/2022.
//

import SwiftUI

class UsersAdminViewModel: ObservableObject {

  @Published var usersLimitedDetailsList = [UserLimitedDetails]()
  @Published var selectedUser: UserLimitedDetails?
  @Published var isShowingUsersDetailsView = false
  
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
      let userLimitedDetails = UserLimitedDetails(id: user.id, pseudo: user.pseudo, profileImageUrl: user.profileImageUrl, isAdmin: user.isAdmin)
      usersLimitedDetailsList.append(userLimitedDetails)
    }
  }

}
