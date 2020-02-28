//
//  VKAPIManager.swift
//  Training Task
//
//  Created by Veremey, Daniil on 2/17/20.
//  Copyright © 2020 Veremey, Daniil. All rights reserved.
//

import Foundation


enum FetchState {
    case refresh
    case loadMore
}

struct VKAPI {
    static let APIToken = AuthService.VKAccessValues()
}


enum VKQueryType {
    
    var parameters: [String: Any] {
        
        switch self {
        case .groups(let count, let loadingOffset):
            guard let id = AuthService.VKAccessValues().id, let token = AuthService.VKAccessValues().token, let version = ConfigurationService.shared.version else { return [:] }
            return ["user_id": id, "v": version, "access_token": token, "extended": "1", "count": count, "offset": loadingOffset]
            
        case .wall(let count, let loadingOffset):
            guard let id = AuthService.VKAccessValues().id, let token = AuthService.VKAccessValues().token, let version = ConfigurationService.shared.version else { return [:] }
            return ["user_id": id, "v": version, "access_token": token, "count": count, "offset": loadingOffset]
            
        case .users:
            guard let id = AuthService.VKAccessValues().id, let token = AuthService.VKAccessValues().token, let version = ConfigurationService.shared.version else { return [:] }
            return ["user_id": id, "v": version, "access_token": token, "extended": "1", "fields": "photo_200"]
            
        case .post(let message):
            guard let token = AuthService.VKAccessValues().token, let version = ConfigurationService.shared.version else { return [:] }
            return ["message": message, "access_token": token, "v": version]
            
        case .authorize:
            guard let appId = ConfigurationService.shared.appId, let display = ConfigurationService.shared.display, let redirect = ConfigurationService.shared.redirectURI, let scope = ConfigurationService.shared.scope, let response = ConfigurationService.shared.responseType, let version = ConfigurationService.shared.version else { return [:] }
            return ["client_id": appId, "display": display, "redirect_uri": redirect, "scope": scope, "response_type": response,"v": version]
        }
    }
    
    var URLString: String {
        guard let baseURL = ConfigurationService.shared.baseURL else { return "" }
        let url = "\(baseURL)/method/"
        switch self {
        case .groups:
            return url + (ConfigurationService.shared.groupsMethod ?? "")
        case .wall:
            return url + (ConfigurationService.shared.wallMethod ?? "")
        case .users:
            return url + (ConfigurationService.shared.userMethod ?? "")
        case .post:
            return url + (ConfigurationService.shared.wallPostMethod ?? "")
        case .authorize:
            return ConfigurationService.shared.authURL ?? ""
        }
    }
    
    case groups(count: Int, offset: Int)
    case wall(count: Int, offset: Int)
    case users
    case post(message: String)
    case authorize
}
