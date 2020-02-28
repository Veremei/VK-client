//
//  GroupResponseDecoder.swift
//  Training Task
//
//  Created by Veremey, Daniil on 2/26/20.
//  Copyright © 2020 Veremey, Daniil. All rights reserved.
//

import Foundation

class JSONToGroupResponseDecoder: ResponseDecoder<GroupsModel?> {
    
    override func decode(response: HTTPURLResponse, from data: Data) throws -> GroupsModel? {
        let feedData = try? JSONDecoder().decode(GroupsModel.self, from: data)
        return feedData
    }
    
}
