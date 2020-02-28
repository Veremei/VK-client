//
//  WallPostRoute.swift
//  Training Task
//
//  Created by Veremey, Daniil on 2/27/20.
//  Copyright © 2020 Veremey, Daniil. All rights reserved.
//

import Alamofire

public enum WallPostRoute {

    static func getRoute(message: String) -> APIRoute<Void> {

        let route = APIRoute(queryType: .post(message: message), method: HTTPMethod.post, encoding: URLEncoding.httpBody, decoder: JSONToPostResponseDecoder())
        return route
    }

}
