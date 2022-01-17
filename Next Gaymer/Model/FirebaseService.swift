//
//  RegisterService.swift
//  Next Gaymer
//
//  Created by Fabien Saint Germain on 14/01/2022.
//

import Foundation
import Firebase
import GoogleSignIn

class FirebaseService {
    
    let db = Firestore.firestore()
    
    // User Creation
    func createUser(userEmail: String, userPassword: String, completionHandler: @escaping(Bool, String?) -> Void) {
        
        Auth.auth().createUser(withEmail: userEmail, password: userPassword) { authResult, error in
            guard authResult != nil, error == nil else {
                let errorMessage = error?.localizedDescription ?? ""
                return completionHandler(false, errorMessage)
            }
            
            DispatchQueue.main.async {
                switch authResult {
                case .none:
                    let errorMessage = error?.localizedDescription ?? ""
                    return completionHandler(false, errorMessage)
                case .some(_):
                    return completionHandler(true, nil)
                }
            }
        }
    }
    
    func registrateUser(with user: UserDetails, completionHandler: @escaping(Bool, String?) -> Void) {
        
        let userUID = Auth.auth().currentUser?.uid
        
        db.collection("users").document(userUID!).setData([
            "name" : user.name,
            "surname" : user.surname,
            "email": user.email,
            "phoneNumber": user.phoneNumber,
            "street": user.street,
            "zipCode": user.zipCode,
            "city": user.city]) { error in
                guard error == nil else {
                    let errorMessage = error?.localizedDescription ?? ""
                    return completionHandler(false, errorMessage)
                }
                return completionHandler(true, nil)
            }
    }
    
    func loginUser(userEmail: String, userPassword: String, completionHandler: @escaping(Bool, String?) -> Void) {
        
        Auth.auth().signIn(withEmail: userEmail, password: userPassword) { authResult, error in
            guard authResult != nil, error == nil else {
                let errorMessage = error?.localizedDescription ?? ""
                return completionHandler(false, errorMessage)
            }
            
            DispatchQueue.main.async {
                switch authResult {
                case .none:
                    let errorMessage = error?.localizedDescription ?? ""
                    return completionHandler(false, errorMessage)
                case .some(_):
                    return completionHandler(true, nil)
                }
            }
        }
    }
    
    func googleLoginUser(completionHandler: @escaping(Bool, String) -> Void) {
        
        guard let clientID = FirebaseApp.app()?.options.clientID else { return }
        let config = GIDConfiguration(clientID: clientID)
        
        GIDSignIn.sharedInstance.signIn(with: config, presenting: LoginView().getRootViewController()) { user, error in
            guard error == nil else {
                let errorMessage = error?.localizedDescription ?? ""
                return completionHandler(false, errorMessage)
            }

            guard let authentication = user?.authentication,
                  let idToken = authentication.idToken
            else {
                let errorMessage = error?.localizedDescription ?? ""
              return completionHandler(false, errorMessage)
            }

            let credential = GoogleAuthProvider.credential(withIDToken: idToken, accessToken: authentication.accessToken)
            
            Auth.auth().signIn(with: credential) { result, error in
                guard error == nil else {
                    let errorMessage = error?.localizedDescription ?? ""
                    return completionHandler(false, errorMessage)
                }
                
                guard let user = result?.user else {
                    return completionHandler(false, "Error")
                    
                }
                return completionHandler(true, user.displayName ?? "")
            }
        }
    }
    
    func logoutUser(completionHandler: @escaping(Bool, String?) -> Void) {
        
        GIDSignIn.sharedInstance.signOut()
        
        let firebaseAuth = Auth.auth()
        do {
            try firebaseAuth.signOut()
            return completionHandler(true, "")
        } catch let signOutError as NSError {
            let errorMessage = signOutError.localizedDescription
            return completionHandler(false, errorMessage)
        }
    }
    
    func resetPassword(emailUser: String, completionHandler: @escaping(Bool, String?) -> Void) {
        Auth.auth().sendPasswordReset(withEmail: emailUser) { error in
            guard error == nil else {
                let errorMessage = error?.localizedDescription ?? ""
                return completionHandler(false, errorMessage)
            }
            return completionHandler(true, nil)
        }
    }
    
    func fetchUser() {
        
        let userID = Auth.auth().currentUser?.uid
        
        let docRef = db.collection("users").document(userID!)
        
        docRef.getDocument { (document, error) in
            if let document = document, document.exists {
                let dataDescription = document.data().map(String.init(describing: )) ?? "nil"
                print(dataDescription)
            } else {
                print("fail")
            }
        }
    }
}
