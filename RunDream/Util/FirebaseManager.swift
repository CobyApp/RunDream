//
//  FirebaseManager.swift
//  RunDream
//
//  Created by Coby on 9/24/24.
//

import Foundation

import Firebase
import FirebaseAuth
import FirebaseFirestore

class FirebaseManager: NSObject {
    
    let auth: Auth
    let firestore: Firestore
    
    static let shared = FirebaseManager()
    
    override init() {
        FirebaseApp.configure()
        
        self.auth = Auth.auth()
        self.firestore = Firestore.firestore()
        
        super.init()
        
        self.login()
    }
    
    func login() {
        Auth.auth().signInAnonymously { (res, err) in
            if err != nil {
                print(err!.localizedDescription)
                return
            }
            
            print("Login Success: \(res!.user.uid)")
        }
    }
}
