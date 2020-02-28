//
//  SettingsResponseDecoder.swift
//  Training Task
//
//  Created by Veremey, Daniil on 2/26/20.
//  Copyright © 2020 Veremey, Daniil. All rights reserved.
//

import Foundation

class JSONToSettingsResponseDecoder: ResponseDecoder<SettingsResponse?> {
    
    override func decode(response: HTTPURLResponse, from data: Data) throws -> SettingsResponse? {
        let userSettings = try? JSONDecoder().decode(UserSettings.self, from: data)
        return userSettings?.response.first
    }
    
}
