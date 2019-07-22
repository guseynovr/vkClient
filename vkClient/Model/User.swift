//
//  User.swift
//  vkClient
//
//  Created by Ruslan Guseynov on 06/07/2019.
//  Copyright © 2019 Ruslan Guseynov. All rights reserved.
//

import UIKit

struct User {
    let id: Int
    var firstName: String
    var lastName: String
    var avatarImageName: String
    var photos: [String]
    
    static func getFriends() -> [User] {
        return [
            User(id: 1, firstName: "Bruce", lastName: "Wayne", avatarImageName: "batman-avatar", photos: ["batman1", "batman2", "batman3", "batman4", "batman5", "batman6", "batman7", "batman8"]),
            User(id: 2, firstName: "Jason", lastName: "Todd", avatarImageName: "robin-avatar", photos: ["robin1", "robin2", "robin3", "robin4"]),
            User(id: 3, firstName: "Harley", lastName: "Quinn", avatarImageName: "harley-avatar", photos: ["harley1", "harley2", "harley3"]),
            User(id: 4, firstName: "Jack", lastName: "Napier", avatarImageName: "joker-avatar", photos: ["joker1", "joker2", "joker3", "joker4", "joker5", "joker6"]),
            User(id: 5, firstName: "Lucy", lastName: "Wyldstyle", avatarImageName: "lucy-avatar", photos: ["lucy1", "lucy2", "lucy3", "lucy4"]),
            User(id: 6, firstName: "Will", lastName: "Smith", avatarImageName: "will-smith", photos: ["will-smith"]),
            User(id: 7, firstName: "Keanu", lastName: "Reeves", avatarImageName: "keanu-reeves", photos: ["keanu-reeves"]),
            User(id: 8, firstName: "Charlize", lastName: "Theron", avatarImageName: "charlize-theron", photos: ["charlize-theron"]),
            User(id: 9, firstName: "Nicole", lastName: "Kidman", avatarImageName: "nicole-kidman", photos: ["nicole-kidman"]),
            User(id: 10, firstName: "Rachel", lastName: "McAdams", avatarImageName: "rachel-mcadams", photos: ["rachel-mcadams"]),
            User(id: 11, firstName: "Ellen", lastName: "Page", avatarImageName: "ellen-page", photos: ["ellen-page"]),
            User(id: 12, firstName: "Rami", lastName: "Malek", avatarImageName: "rami-malek", photos: ["rami-malek"]),
            User(id: 13, firstName: "Amy", lastName: "Adams", avatarImageName: "amy-adams", photos: ["amy-adams"]),
            User(id: 14, firstName: "Tim", lastName: "Burton", avatarImageName: "tim-burton", photos: ["tim-burton"]),
            User(id: 15, firstName: "James", lastName: "McAvoy", avatarImageName: "james-mcavoy", photos: ["james-mcavoy"]),
            User(id: 16, firstName: "Emma", lastName: "Watson", avatarImageName: "emma-watson", photos: ["emma-watson"]),
            User(id: 17, firstName: "Charlie", lastName: "Brooker", avatarImageName: "charlie-brooker", photos: ["charlie-brooker"])
        ]
    }
}
