//
//  Theme.swift
//  Training Task
//
//  Created by Veremey, Daniil on 2/24/20.
//  Copyright © 2020 Veremey, Daniil. All rights reserved.
//

import UIKit

struct ThemeManager {
    
    var barTintColor : UIColor {
        get {
            return #colorLiteral(red: 0.2549019754, green: 0.2745098174, blue: 0.3019607961, alpha: 1)
        }
    }
    
    var tintColor : UIColor {
          get {
              return #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
          }
      }
    
    func applyTheme() {
        UITabBar.appearance().tintColor = tintColor
        UITabBar.appearance().barTintColor = barTintColor
        UINavigationBar.appearance().barTintColor = barTintColor
        UINavigationBar.appearance().titleTextAttributes = [NSAttributedString.Key.foregroundColor: tintColor]
    }
}
