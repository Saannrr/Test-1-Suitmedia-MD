//
//  User.swift
//  Test 1 Suitmedia MD
//
//  Created by Ihsan on 14/08/24.
//

import Foundation

struct UserResponse: Codable {
    let data: [User]
}

struct User: Codable {
    let id: Int
    let email: String
    let first_name: String
    let last_name: String
    let avatar: String
}
