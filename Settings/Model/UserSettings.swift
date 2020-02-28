//
//  UserSettings.swift
//  Training Task
//
//  Created by Veremey, Daniil on 2/12/20.
//  Copyright © 2020 Veremey, Daniil. All rights reserved.
//

import Foundation

struct UserSettings: Codable {
    let response: [SettingsResponse]
}

struct SettingsResponse: Codable {
    let id: Int
    let firstName, lastName, photo: String
    
    enum CodingKeys: String, CodingKey {
        case id
        case firstName = "first_name"
        case lastName = "last_name"
        case photo = "photo_200"
    }
    
}
