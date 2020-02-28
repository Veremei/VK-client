//
//  ConfigurationModel.swift
//  Training Task
//
//  Created by Veremey, Daniil on 2/24/20.
//  Copyright © 2020 Veremey, Daniil. All rights reserved.
//

import Foundation


struct ConfigurationModel: Codable {
    let API: APIModel
    let method : MethodModel
    
    enum CodingKeys: String, CodingKey {
        case API
        case method = "Method"
    }
    
}

struct APIModel: Codable {
    let baseURL: String
    let authURL: String
    let appId: String
    let display: String
    let scope: String
    let redirectURI: String
    let responseType: String
    let version: String
    
    enum CodingKeys: String, CodingKey {
        case baseURL = "Base URL"
        case authURL = "Auth URL"
        case appId = "App ID"
        case display = "Display"
        case scope = "Scope"
        case redirectURI = "Redirect URI"
        case responseType = "Response type"
        case version = "Version"
    }
    
}

struct MethodModel: Codable {
    let user : String
    let groups : String
    let wall : String
    let wallPost : String
    
    enum CodingKeys: String, CodingKey {
        case user = "User"
        case groups = "Groups"
        case wall = "Wall"
        case wallPost = "Wall post"
    }
}
