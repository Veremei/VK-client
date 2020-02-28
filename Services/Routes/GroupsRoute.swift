//
//  GroupsService.swift
//  Training Task
//
//  Created by Veremey, Daniil on 2/26/20.
//  Copyright © 2020 Veremey, Daniil. All rights reserved.
//

import Alamofire

public enum GroupsRoute {

    static func getRoute(count: Int, offset: Int) -> APIRoute<GroupsModel?> {

        let route = APIRoute(queryType: .groups(count: count, offset: offset), method: HTTPMethod.get, encoding: URLEncoding.default, decoder: JSONToGroupResponseDecoder())
        return route
    }

}
