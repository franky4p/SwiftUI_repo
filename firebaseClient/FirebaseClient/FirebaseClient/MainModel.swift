//
//  MainModel.swift
//  FirebaseClient
//
//  Created by macbook on 27.01.2021.
//

import Foundation
import Firebase

struct MainModel {
    var loginSuccessful: Bool = false
    var errors: String?
    var user: AuthDataResult?
    
    init() {
        FirebaseApp.configure()
    }
    
    private mutating func resetParameters() {
        loginSuccessful = false
        errors = nil
        user = nil
    }
    
    mutating func connect(user: AuthDataResult?) {
        self.loginSuccessful = true
        self.user = user
    }
    
    mutating func disConnect() {
        do {
            try Auth.auth().signOut()
            resetParameters() 
        } catch (let error) {
            print("Auth sign out failed: \(error)")
        }
    }
    
}


class UserAuthorization {
    
    let name: String
    let uid: String
    let ref: DatabaseReference?
    
    init(name: String, uid: String) {
        self.ref = nil
        self.name = name
        self.uid = uid
    }
    
    init?(snapshot: DataSnapshot) {
        guard
            let value = snapshot.value as? [String: Any],
            let uid = value["uid"] as? String,
            let name = value["name"] as? String
        else { return nil }
        
        self.ref = snapshot.ref
        self.name = name
        self.uid = uid
    }
    
    func toAnyObject() -> [String: Any] {
        return [
            "name": name,
            "uid": uid
        ]
    }
}

