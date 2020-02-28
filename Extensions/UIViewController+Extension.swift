//
//  UIViewController + Storyboard.swift
//  Training Task
//
//  Created by Veremey, Daniil on 2/13/20.
//  Copyright © 2020 Veremey, Daniil. All rights reserved.
//

import Foundation
import UIKit

extension UIViewController {
    
    class func loadFromStoryboard<T: UIViewController>() -> T {
        let name = String(describing: T.self)
        let storyboard = UIStoryboard(name: name, bundle: nil)
        if let viewController = storyboard.instantiateInitialViewController() as? T {
            return viewController
        } else {
            fatalError("Error in view controller name: \(name)")
        }
    }
    
    func ErrorAlertController(withTitle title: String, message: String, actionTitle: String) -> UIAlertController {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let action = UIAlertAction(title: actionTitle, style: .default, handler: nil)
        alertController.addAction(action)
        return alertController
//        present(alertController, animated: true, completion: nil)
    }
    
}
