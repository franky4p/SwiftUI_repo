//
//  ViewModel.swift
//  FirebaseClient
//
//  Created by macbook on 27.01.2021.
//

import SwiftUI
import Firebase

class ViewModel: ObservableObject{

    @Published private var model: MainModel = MainModel()
    
    func loginSuccessful()-> Bool {
        model.loginSuccessful
    }
    
    func errorsFound() -> String? {
        if let errors = model.errors {
            return errors
        }
        return nil
    }
    
    func connect(uzerName: String, uzerPas: String) {
        Auth.auth().signIn(withEmail: uzerName, password: uzerPas) { [weak self] user, error in
            if let error = error, user == nil {
                self?.model.errors = error.localizedDescription
            } else {
                self?.model.connect(user: user)
            }
        }
    }
    
    func registration(uzerName: String, uzerPas: String) {
        Auth.auth().createUser(withEmail: uzerName, password: uzerPas) { [weak self] user, error in
            if let error = error {
                self?.model.errors = error.localizedDescription
            }else {
                self?.connect(uzerName: uzerName, uzerPas: uzerPas)
            }
        }
    }
    
    func disConnect(){
        model.disConnect()
    }
    
    func currentUser() -> String {
        model.user?.user.email ?? ""
    }
    
    func saveToFireBase() {
        let name = model.user?.user.email ?? ""
        let uid = model.user?.user.uid ?? ""
        
        let user = UserAuthorization(name: name, uid: uid)
        let ref = Database.database().reference(withPath: "UserAuthorization")
        let cityRef = ref.child(name.replacingOccurrences(of: ".", with: "")) //Must be a non-empty string and not contain '.' '#' '$' '[' or ']''
        cityRef.setValue(user.toAnyObject())
    }
}
