//
//  StringConfigurationService.swift
//  Training Task
//
//  Created by Veremey, Daniil on 2/24/20.
//  Copyright © 2020 Veremey, Daniil. All rights reserved.
//

import UIKit

class StringConfigurationService {
    
    static let shared = StringConfigurationService()
    
    private var configuration : StringConfigurationModel?
    
    var feedTitle: String? {
        get {
            return configuration?.title.feed
        }
    }
    
    var groupsTitle: String? {
        get {
            return configuration?.title.groups
        }
    }
    
    var settingsTitle: String? {
        get {
            return configuration?.title.settings
        }
    }
    
    private init() {
        parsePlist()
    }
    
    func parsePlist() {
        guard  let path = Bundle.main.path(forResource: "Strings", ofType: "plist"),
            let xml = FileManager.default.contents(atPath: path),
            let configurationData = try? PropertyListDecoder().decode(StringConfigurationModel.self, from: xml) else { return }
        configuration = configurationData
    }
    
}
