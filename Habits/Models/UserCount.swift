//
//  UserCount.swift
//  Habits
//
//  Created by Олег Алексеев on 21.07.2023.
//

import Foundation

struct UserCount {
    let user: User
    let count: Int
}

extension UserCount: Codable { }

extension UserCount: Hashable {
    
}
