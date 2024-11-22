//
//  FirebaseManager.swift
//  E-Commerce-ProgrammaticUI-MVVM
//
//  Created by Bayram Yeleç on 22.11.2024.
//

import Foundation
import FirebaseAuth
import FirebaseFirestore

class FirebaseManager {
    
    static let shared = FirebaseManager()
    let db = Firestore.firestore()
    
    
    func createUser(username: String, email: String, password: String) {
        
        Auth.auth().createUser(withEmail: email, password: password) { result, error in
            if error != nil {
                print(error?.localizedDescription ?? "")
            }
            if let result = result {
                self.db.collection("users").document(result.user.uid).setData(["username": username])
            }
        }
    }
    
    
    func loginUser(email: String, password: String, completion: @escaping (Result<User, Error>) -> Void) {
        Auth.auth().signIn(withEmail: email, password: password) { (result, error) in
            if let error = error {
                completion(.failure(error))
                return
            }
            guard let user = result?.user else {
                completion(.failure(NSError(domain: "FirebaseError", code: -1, userInfo: [NSLocalizedDescriptionKey: "User not found"])))
                return
            }
            completion(.success(user))
        }
    }
    
    
    func logoutUser(completion: @escaping (Result<Void, Error>) -> Void) {
        do {
            try Auth.auth().signOut()
            completion(.success(()))
        } catch let error {
            completion(.failure(error))
        }
    }
    
    
    func fetchUser(completion: @escaping (String?) -> Void) {
        
        guard let userId = Auth.auth().currentUser?.uid else {
            completion(nil)
            return
        }
        
        db.collection("users").document(userId).getDocument { (snapshot, error) in
            if let error = error {
                print(error.localizedDescription)
                completion(nil)
                return
            }
            
            guard let document = snapshot, document.exists else {
                print("Veri yok")
                completion(nil)
                return
            }
            
            let data = document.data()
            if let username = data?["username"] as? String {
                completion(username)
            } else {
                completion(nil)
            }
        }
    }
    
}
    



