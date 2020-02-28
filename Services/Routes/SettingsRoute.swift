//
//  SettingsService.swift
//  Training Task
//
//  Created by Veremey, Daniil on 2/26/20.
//  Copyright © 2020 Veremey, Daniil. All rights reserved.
//

import Alamofire

public enum SettingsRoute {

    static func getRoute() -> APIRoute<SettingsResponse?> {

        let route = APIRoute(queryType: .users, method: HTTPMethod.get, encoding: URLEncoding.default, decoder: JSONToSettingsResponseDecoder())
        return route
    }

}
