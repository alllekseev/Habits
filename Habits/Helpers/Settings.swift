//
//  Settings.swift
//  Habits
//
//  Created by Олег Алексеев on 12.07.2023.
//

import Foundation

struct Settings {
    static var shared = Settings()
    
    private let defaults = UserDefaults.standard
    
    var favoriteHabits: [Habit] {
        get {
            return unarchiveJSON(key: R.Strings.Habits.favoriteHabits) ?? []
        }
        set {
            archiveJSON(value: newValue, key: R.Strings.Habits.favoriteHabits)
        }
    }
    
    private func archiveJSON<T: Encodable>(value: T, key: String) {
        let data = try! JSONEncoder().encode(value)
        let string = String(data: data, encoding: .utf8)
        defaults.set(string, forKey: key)
    }
    
    private func unarchiveJSON<T: Decodable>(key: String) -> T? {
        guard let string = defaults.string(forKey: key),
              let data = string.data(using: .utf8) else {
            return nil
        }
        
        return try! JSONDecoder().decode(T.self, from: data)
    }
    
    mutating func toggleFavourite(_ habit: Habit) {
        var favorites = favoriteHabits
        
        if favorites.contains(habit) {
            favorites = favorites.filter { $0 != habit }
        } else {
            favorites.append(habit)
        }
        
        favoriteHabits = favorites
    }
}
