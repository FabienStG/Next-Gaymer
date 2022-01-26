//
//  MessagesView.swift
//  Next Gaymer
//
//  Created by Fabien Saint Germain on 23/01/2022.
//

import SwiftUI

struct MessageView: View {
  
  let message: ChatMessage
  let currentUserId: String
  
  var body: some View {
    VStack {
      if message.senderUserId == currentUserId {
        HStack {
          Spacer()
          HStack {
            Text(message.text)
              .foregroundColor(.white)
          }
          .padding()
          .background(Color.blue)
          .cornerRadius(8)
        }
      } else {
        HStack {
          HStack {
            Text(message.text)
              .foregroundColor(.black)
          }
          .padding()
          .background(Color(.init(white: 0.8, alpha: 1)))
          .cornerRadius(8)
          Spacer()
        }
      }
    }
    .padding(.horizontal)
    .padding(.top, 8)
  }
}

struct MessageView_Previews: PreviewProvider {
    static var previews: some View {
      MessageView(message: ChatMessage(id: "FakeId", senderUserId: "FakeId", recipientUserId: "FakeId", text: "Ceci est un test", timestamp: Date()), currentUserId: "Fake id")
    }
}
