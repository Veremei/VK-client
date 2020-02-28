//
//  RealmFeedItemModel.swift
//  Training Task
//
//  Created by Veremey, Daniil on 2/19/20.
//  Copyright © 2020 Veremey, Daniil. All rights reserved.
//


import Foundation
import RealmSwift

final class RealmFeedItemModel: Object {
    @objc dynamic var date: String? = nil
    @objc dynamic var text: String? = nil
}
