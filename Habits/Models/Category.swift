//
//  Category.swift
//  Habits
//
//  Created by Олег Алексеев on 12.07.2023.
//

import Foundation

struct Category {
    let name: String
    let color: Color
}

extension Category: Codable { }
