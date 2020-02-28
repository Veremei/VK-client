//
//  AppController.swift
//  Training Task
//
//  Created by Veremey, Daniil on 2/19/20.
//  Copyright © 2020 Veremey, Daniil. All rights reserved.
//

import UIKit

final class AppController {
    
    static let shared = AppController()
    
    let themeManager = ThemeManager()
    
    var window: UIWindow!
    var rootViewController: UIViewController? {
        didSet {
            if let vc = rootViewController {
                window.rootViewController = vc
                window.rootViewController?.dismiss(animated: true, completion: nil)
                window.makeKeyAndVisible()
            }
        }
    }
    
    init() {
        themeManager.applyTheme()
        
        NotificationCenter.default.addObserver(forName: .loginStatusChanged, object: nil, queue: .main) { [weak self] (_) in
            guard let self = self else { return }
            self.handleAuthState()
        }
    }
    
    func show(in window: UIWindow?) {
        guard let window = window else { fatalError("Cannot layout app with a nil window.") }
        self.window = window
        rootViewController = SplashViewController()
    }
    
    func handleAuthState() {
        if AuthService.isSignedIn {
            rootViewController = MainTabBarController()
            
        } else {
            let loginVC: LoginViewController = LoginViewController.loadFromStoryboard()
            rootViewController = loginVC
        }
    }
    
}
