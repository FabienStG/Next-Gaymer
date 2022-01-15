//
//  RealTimeMessagingView.swift
//  Next Gaymer
//
//  Created by Fabien Saint Germain on 14/01/2022.
//

import SwiftUI
import Firebase

struct RealTimeMessagingView: View {
    
    @State var name = ""
    var body: some View {
        NavigationView {
            ZStack {
                Color.orange
                
                VStack {
                    Image(systemName: "person.circle.fill")
                        .resizable()
                        .frame(width: 60, height: 60, alignment: .top)
                        .padding(.top, 12)
                    TextField("Nom", text: $name)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .padding()
                    
                    if self.name != "" {
                        NavigationLink(destination: MessagePage(name: self.name)) {
                            HStack {
                                Text("Rejoindre")
                                Image(systemName: "arrow.right.circle.fill")
                                    .resizable()
                                    .frame(width: 20, height: 20)
                            }
                        }
                        .frame(width: 150, height: 54)
                        .background(Color.orange)
                        .foregroundColor(.white)
                        .cornerRadius(27)
                        .padding(.bottom, 15)
                    }
                }
                .padding()
                .background(Color.white)
                .cornerRadius(20)
                .padding()
            }
            .edgesIgnoringSafeArea(.all)
        }
        .animation(.default)
    }
}

struct RealTimeMessagingView_Previews: PreviewProvider {
    static var previews: some View {
        RealTimeMessagingView()
    }
}

struct MessagePage: View {
    
    var name = ""
    @ObservedObject var message = observer()
    @State var typeMessage = ""
    var body: some View {

        VStack {
            List(message.message) { i in
    
                if i.name == self.name {
                    MessageRow(message: i.message, myMessage: true, user: i.name)
                } else {
                    MessageRow(message: i.message, myMessage: false, user: i.name)
                }
            }
            .navigationTitle("Chat")
            .navigationBarTitleDisplayMode(.inline)
            
            HStack {
                TextField("Message", text: $typeMessage)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                Button {
                    self.message.addMessage(message: self.typeMessage, user: name)
                    self.typeMessage = ""
                } label: {
                    Text("Envoyer")
                }

                }
            .padding()
            }
        }
}

class observer: ObservableObject {
    
    @Published var message = [Datatype]()
    
    init() {
        let db = Firestore.firestore()
        
        db.collection("messages").addSnapshotListener { snap, error in
            guard error == nil else {
                print(error?.localizedDescription ?? "")
                return
            }
            for i in snap!.documentChanges {
                if i.type == .added {
                    let name = i.document.get("name") as! String
                    let message = i.document.get("message") as! String
                    let id = i.document.documentID
                    
                    self.message.append(Datatype(id: id, name: name, message: message))
                }
            }
        }
    }
    
    func addMessage(message: String, user: String) {
        
        let db = Firestore.firestore()
        
        db.collection("messages").addDocument(data: ["message": message, "name": user]) { error in
            guard error == nil else {
                print(error?.localizedDescription ?? "")
                return
            }
            print("success")
        }
    }
}

struct Datatype: Identifiable {
    
    var id: String
    var name: String
    var message: String
}

struct MessageRow: View {
    
    var message = ""
    var myMessage = false
    var user = ""
    
    var body: some View {
        HStack {
            if myMessage {
                Spacer()
                Text(message)
                    .padding(8)
                    .background(Color.red)
                    .foregroundColor(.white)
                    .cornerRadius(6)
            } else {
                
                VStack(alignment: .leading) {
                    Text(message)
                        .padding(8)
                        .foregroundColor(.white)
                        .background(Color.green)
                    Text(user)
                }
                Spacer()
            }
        }
    }
}
