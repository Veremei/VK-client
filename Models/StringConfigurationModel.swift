//
//  StringConfigurationModel.swift
//  Training Task
//
//  Created by Veremey, Daniil on 2/24/20.
//  Copyright © 2020 Veremey, Daniil. All rights reserved.
//

import Foundation

struct StringConfigurationModel: Codable {
    let title: StringTitleModel
    
    enum CodingKeys: String, CodingKey {
        case title = "Title"
    }
    
}

struct StringTitleModel: Codable {
    let feed, settings, groups: String
    
    enum CodingKeys: String, CodingKey {
        case feed = "Feed"
        case settings = "Settings"
        case groups = "Groups"
    }
}
