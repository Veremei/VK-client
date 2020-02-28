//
//  UIRefreshControl+Extension.swift
//  Training Task
//
//  Created by Veremey, Daniil on 2/27/20.
//  Copyright © 2020 Veremey, Daniil. All rights reserved.
//

import UIKit

extension UIRefreshControl {
    func programaticallyBeginRefreshing(in tableView: UITableView) {
        beginRefreshing()
        let offsetPoint = CGPoint.init(x: 0, y: -frame.size.height)
        tableView.setContentOffset(offsetPoint, animated: true)
    }
}
