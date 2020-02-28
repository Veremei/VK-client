//
//  MainTabBarController.swift
//  Training Task
//
//  Created by Veremey, Daniil on 2/13/20.
//  Copyright © 2020 Veremey, Daniil. All rights reserved.
//

import UIKit

final class MainTabBarController: UITabBarController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let settingsVC: SettingsViewController = SettingsViewController.loadFromStoryboard()
        let feedVC: FeedViewController = FeedViewController.loadFromStoryboard()
        let communitiesVC: GroupsViewController = GroupsViewController.loadFromStoryboard()
        
        viewControllers = [
            generateViewController(rootViewController: feedVC, title: StringConfigurationService.shared.feedTitle, image: AssetsService.shared.feedIcon),
            generateViewController(rootViewController: communitiesVC, title: StringConfigurationService.shared.groupsTitle, image: AssetsService.shared.groupsIcon),
            generateViewController(rootViewController: settingsVC, title: StringConfigurationService.shared.settingsTitle, image: AssetsService.shared.settingsIcon)
        ]
        
    }
    
    private func generateViewController(rootViewController: UIViewController, title: String?, image: UIImage?) -> UIViewController {
        let navigationVC = UINavigationController(rootViewController: rootViewController)
        navigationVC.tabBarItem.image = image
        rootViewController.navigationItem.title = title
        return navigationVC
    }
    
    
    
}
