//
//  FeedService.swift
//  Training Task
//
//  Created by Veremey, Daniil on 2/26/20.
//  Copyright © 2020 Veremey, Daniil. All rights reserved.
//

import Alamofire

public enum FeedRoute {

    static func getRoute(count: Int, offset: Int) -> APIRoute<FeedModel?> {

        let route = APIRoute(queryType: .wall(count: count, offset: offset), method: HTTPMethod.get, encoding: URLEncoding.default, decoder: JSONToFeedResponseDecoder())
        return route
    }

}
