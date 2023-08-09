//
//  DatabaseManager.swift
//  Instagram
//
//  Created by Tomas D. De Andrade Gomes on 8/8/23.
//

import FirebaseDatabase

public class DatabaseManager {
    static let shared = DatabaseManager()
    
    // MARK: - Public

    
    /// Check if username and email is available
    /// - Parameters
    ///         - email: String representing email
    ///         - username: String representing username
    public func canCreateNewUser(with email: String, username: String, completion: (Bool) -> Void) {
        
    }
    
}
