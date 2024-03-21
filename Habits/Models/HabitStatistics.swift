//
//  HabitStatistics.swift
//  Habits
//
//  Created by Олег Алексеев on 21.07.2023.
//

import Foundation

struct HabitStatistics {
    let habit: Habit
    let userCounts: [UserCount]
}

extension HabitStatistics: Codable { }
