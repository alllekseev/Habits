//
//  Habit.swift
//  Habits
//
//  Created by Олег Алексеев on 12.07.2023.
//

import Foundation

struct Habit {
    let name: String
    let category: Category
    let info: String
}

extension Habit: Codable { }
