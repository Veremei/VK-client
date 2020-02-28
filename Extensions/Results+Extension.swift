//
//  Results+Extension.swift
//  Training Task
//
//  Created by Veremey, Daniil on 2/19/20.
//  Copyright © 2020 Veremey, Daniil. All rights reserved.
//

import Foundation
import RealmSwift

extension Results {
    func toArray() -> [Element] {
        return compactMap {
            $0
        }
    }
}
