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
            static let favoriteHabits = "favoriteHabits"
            static let followedUserIDs = "followedUserIDs"
        }

        enum Habits {
            static let headerFavorites = "Favorites"

            static let favorite = "Favorite"
            static let unfavorite = "Unfavorite"
        }
        
        enum User {
            static let follow = "Follow"
            static let unfollow = "Unfollow"
        }

        enum SectionHeader: String {
            case kind = "SectionHeader"
            case reuse = "HeaderView"

            var identifier: String {
                return rawValue
            }
        }

        enum ReuseIdentifier {
            static let habit = "Habit"
            static let user = "User"
            static let userCount = "UserCount"
        }
    }

    enum Font {
        static func systemBold(with size: CGFloat) -> UIFont {
            return UIFont.boldSystemFont(ofSize: size)
        }
    }
}

typealias R = Resources
