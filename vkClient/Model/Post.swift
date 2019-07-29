//
//  Post.swift
//  vkClient
//
//  Created by Ruslan Guseynov on 24/07/2019.
//  Copyright © 2019 Ruslan Guseynov. All rights reserved.
//

import Foundation

struct Post {
    let id: Int
    var text: String?
    let author_id: Int
    let photos: [String]?
    var likes: Int = 0
    var comments: Int = 0
    var shares: Int = 0
    
    static func getPosts() -> [Post] {
        return [
            Post(id: 0, text: "Batman is a fictional superhero appearing in American comic books published by DC Comics.", author_id: 1, photos: ["batman8"], likes: 19, comments: 39, shares: 27),
            Post(id: 1, text: "Keanu Charles Reeves is a Canadian actor and musician.", author_id: 7, photos: ["keanu-john-wick", "keanu-devils-advocate-premiere"], likes: 321, comments: 6654, shares: 23),
            Post(id: 2, text: "Charlize Theron is a South African and American actress and producer. She is the recipient of several accolades, including an Academy Award, a Golden Globe Award, and the Silver Bear for Best Actress.", author_id: 8, photos: ["charlize-theron-post"], likes: 4, comments: 4, shares: 4),
            Post(id: 3, text: "Post 3", author_id: 2, photos: ["harley1"], likes: 12, comments: 2, shares: 0),
            Post(id: 4, text: "Post 4", author_id: 9, photos: nil, likes: 123, comments: 123, shares: 123),
            Post(id: 4, text: "Post 5", author_id: 10, photos: nil, likes: 999, comments: 781, shares: 42),
            Post(id: 5, text: "Post 6", author_id: 11, photos: nil, likes: 999, comments: 781, shares: 42),
            Post(id: 6, text: "Post 7", author_id: 12, photos: nil, likes: 999, comments: 781, shares: 42),
            Post(id: 7, text: "Post 8", author_id: 13, photos: nil, likes: 999, comments: 781, shares: 42),
            Post(id: 8, text: "Post 9", author_id: 14, photos: nil, likes: 999, comments: 781, shares: 42),
            Post(id: 9, text: "Post 10", author_id: 15, photos: nil, likes: 999, comments: 781, shares: 42)
        ]
    }
}
