//
//  Resources.swift
//  Habits
//
//  Created by Олег Алексеев on 12.07.2023.
//

import UIKit

enum Resources {
    enum Strings {
        enum Settings {
            
        }
        
        enum Habits {
            static let favoriteHabits = "favoriteHabits"
            
            static let headerFavorites = "Favorites"
            
            static let favorite = "Favorite"
            static let unfavorite = "Unfavorite"
        }
        
        enum SectionHeader: String {
            case kind = "SectionHeader"
            case reuse = "HeaderView"
            
            var identifier: String {
                return rawValue
            }
        }
    }
    
    enum Font {
        static func systemBold(with size: CGFloat) -> UIFont {
            return UIFont.boldSystemFont(ofSize: size)
        }
    }
}

typealias R = Resources
