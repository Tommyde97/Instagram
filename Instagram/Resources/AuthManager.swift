//
//  AuthManager.swift
//  Instagram
//
//  Created by Tomas D. De Andrade Gomes on 8/8/23.
//

import FirebaseAuth

public class AuthManager {
    static let shared = AuthManager()
    
    // MARK: - Public
    
    public func registerNewUser(username: String, email: String, password: String) {
        /*
         - Check if username is available
         - Check if email is available
         */
        
        DatabaseManager.shared.canCreateNewUser(with: email, username: username) { canCreate in
            if canCreate {
                /*
                 - Create account
                 - Insert account to Database
                 */
            }
        }
    }
    
    public func loginUser(username: String?, email: String?, password: String, completion: @escaping (Bool) -> Void) {
        if let email = email {
            //Email Log in
            
            Auth.auth().signIn(withEmail: email, password: password) { authResult, error in
                guard authResult != nil, error == nil else {
                    completion(false)
                    return
                }
                completion(true)
            }
            
        } else if let username = username {
            //Username Log in
            print(username)
        }
        
    }
}
