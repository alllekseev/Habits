//
//  APIService.swift
//  Habits
//
//  Created by Олег Алексеев on 12.07.2023.
//

import Foundation

struct HabitRequest: APIRequest {

    typealias Response = [String: Habit]

    var habitName: String?

    var path: String { "/habits" }
}

struct UserRequest: APIRequest {
    typealias Response = [String: User]

    var path: String { "/users" }
}
