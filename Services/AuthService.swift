//
//  KeychainHelper.swift
//  Training Task
//
//  Created by Veremey, Daniil on 2/19/20.
//  Copyright © 2020 Veremey, Daniil. All rights reserved.
//

import Foundation
import KeychainSwift
import WebKit

typealias VKAPIValues = (id: String?, token: String?)

enum VKAppAccess: String {
    case userId
    case accessToken
}

final class AuthService {
    
    private enum AccessKeys : String {
        case userId
        case accessToken
    }
    
    class var isSignedIn: Bool {
        let keychain = KeychainSwift()
        if keychain.get(AccessKeys.userId.rawValue) != nil && keychain.get(AccessKeys.accessToken.rawValue) != nil {
            return true
        }
        return false
    }
    
    class func VKAccessValues() -> VKAPIValues {
        let keychain = KeychainSwift()
        return (keychain.get(AccessKeys.userId.rawValue), keychain.get(AccessKeys.accessToken.rawValue))
    }
    
    class func signIn(url: URL?) {
        guard let token = url?.fragmentItems["access_token"]?.first, let id = url?.fragmentItems["user_id"]?.first else { return }
        let keychain = KeychainSwift()
        keychain.set(id, forKey: AccessKeys.userId.rawValue)
        keychain.set(token, forKey: AccessKeys.accessToken.rawValue)
        NotificationCenter.default.post(name: .loginStatusChanged, object: nil)
    }
    
    class func signOut() {
        let keychain = KeychainSwift()
        keychain.clear()
        DBService.shared.removeAll()
        
        HTTPCookieStorage.shared.removeCookies(since: Date.distantPast)
        WKWebsiteDataStore.default().fetchDataRecords(ofTypes: WKWebsiteDataStore.allWebsiteDataTypes()) { records in
            records.forEach { record in
                WKWebsiteDataStore.default().removeData(ofTypes: record.dataTypes, for: [record], completionHandler: {})
            }
        }
        
        NotificationCenter.default.post(name: .loginStatusChanged, object: nil)
    }
    
}
