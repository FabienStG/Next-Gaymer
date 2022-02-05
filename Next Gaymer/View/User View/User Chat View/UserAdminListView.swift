//
//  UserAdminListView.swift
//  Next Gaymer
//
//  Created by Fabien Saint Germain on 05/02/2022.
//

import SwiftUI

struct UserAdminListView: View {
  
  @StateObject var userAdminListModel = UserAdminListViewModel()
  
    var body: some View {
        Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
    }
}

struct UserAdminListView_Previews: PreviewProvider {
    static var previews: some View {
        UserAdminListView()
    }
}
