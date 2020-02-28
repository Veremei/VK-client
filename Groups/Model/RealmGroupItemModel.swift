//
//  RealmGroupItem.swift
//  Training Task
//
//  Created by Veremey, Daniil on 2/19/20.
//  Copyright © 2020 Veremey, Daniil. All rights reserved.
//

import Foundation
import RealmSwift

final class RealmGroupItemModel: Object {
    @objc dynamic var name: String? = nil
    @objc dynamic var photo: String? = nil
}
