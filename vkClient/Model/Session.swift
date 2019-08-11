//
//  Session.swift
//  vkClient
//
//  Created by Ruslan Guseynov on 11/08/2019.
//  Copyright © 2019 Ruslan Guseynov. All rights reserved.
//

import Foundation

class Session {
    private var token = "Session"
    private var userId = 0
    
    public static let shared = Session()

    private init() { }
}
