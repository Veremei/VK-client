//
//  AppDelegate.swift
//  Training Task
//
//  Created by Veremey, Daniil on 2/11/20.
//  Copyright © 2020 Veremey, Daniil. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        AppController.shared.show(in: UIWindow(frame: UIScreen.main.bounds))
        return true
    }
    
}

