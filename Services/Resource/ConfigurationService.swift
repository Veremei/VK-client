//
//  ConfigurationService.swift
//  Training Task
//
//  Created by Veremey, Daniil on 2/24/20.
//  Copyright © 2020 Veremey, Daniil. All rights reserved.
//

import UIKit

class ConfigurationService {
    
    static let shared = ConfigurationService()
    
    private var configuration : ConfigurationModel?
    
    
    
    // MARK: - API
    var baseURL: String? {
        get {
            return configuration?.API.baseURL
        }
    }
    
    var authURL: String? {
        get {
            return configuration?.API.authURL
        }
    }
    
    var appId: String? {
        get {
            return configuration?.API.appId
        }
    }
    
    var display: String? {
        get {
            return configuration?.API.display
        }
    }
    
    var scope: String? {
        get {
            return configuration?.API.scope
        }
    }
    
    var redirectURI: String? {
        get {
            return configuration?.API.redirectURI
        }
    }
    
    var responseType: String? {
        get {
            return configuration?.API.responseType
        }
    }
    
    var version: String? {
        get {
            return configuration?.API.version
        }
    }
    
    
    // MARK: - Methods
    var userMethod: String? {
        get {
            return configuration?.method.user
        }
    }
    
    var groupsMethod: String? {
        get {
            return configuration?.method.groups
        }
    }
    
    var wallMethod: String? {
        get {
            return configuration?.method.wall
        }
    }
    
    var wallPostMethod: String? {
        get {
            return configuration?.method.wallPost
        }
    }
    
    private init() {
        parsePlist()
    }
   
    func parsePlist() {
        guard  let path = Bundle.main.path(forResource: "Config", ofType: "plist"),
            let xml = FileManager.default.contents(atPath: path),
            let configurationData = try? PropertyListDecoder().decode(ConfigurationModel.self, from: xml) else { return }
        configuration = configurationData
    }
    
}
