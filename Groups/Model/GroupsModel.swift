//
//  GroupsModel.swift
//  Training Task
//
//  Created by Veremey, Daniil on 2/13/20.
//  Copyright © 2020 Veremey, Daniil. All rights reserved.
//

import Foundation

struct GroupsModel: Codable {
    let response: GroupsResponse?
}

struct GroupsResponse: Codable {
    let count: Int?
    let items: [GroupItemModel]?
}

struct GroupItemModel: Codable {
    let name : String?
    let photo: String?
    
    enum CodingKeys: String, CodingKey {
          case name
          case photo = "photo_200"
      }

}
