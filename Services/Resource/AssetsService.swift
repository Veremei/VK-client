//
//  AssetsService.swift
//  Training Task
//
//  Created by Veremey, Daniil on 2/24/20.
//  Copyright © 2020 Veremey, Daniil. All rights reserved.
//

import UIKit

class AssetsService {
    
    static let shared = AssetsService()
    
    private init() {}

    var splashLogo: UIImage? {
        get {
            return UIImage(named: "vk_logo")
        }
    }
    
    var userIcon: UIImage? {
        get {
            return UIImage(named: "user_icon")
        }
    }
    
    var settingsIcon: UIImage? {
        get {
            return UIImage(named: "settings_icon")
        }
    }
    
    var groupsIcon: UIImage? {
        get {
            return UIImage(named: "groups_icon")
        }
    }
    
    var feedIcon: UIImage? {
        get {
            return UIImage(named: "feed_icon")
        }
    }
    
    var cameraIcon: UIImage? {
        get {
            return UIImage(named: "camera_400")
        }
    }
    
    
}

