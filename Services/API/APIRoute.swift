//
//  APIRoute.swift
//  Training Task
//
//  Created by Veremey, Daniil on 2/26/20.
//  Copyright © 2020 Veremey, Daniil. All rights reserved.
//

import Alamofire

public struct APIRoute<Result> {
    
    public let url: String?
    public let method: HTTPMethod
    public let parameters: [String: Any]
    public let encoding: ParameterEncoding
    public let decoder: ResponseDecoder<Result>
    
    init(queryType: VKQueryType, url: String? = nil, method: HTTPMethod, encoding: ParameterEncoding, decoder: ResponseDecoder<Result>) {
        self.url = queryType.URLString
        self.method = method
        self.parameters = queryType.parameters
        self.encoding = encoding
        self.decoder = decoder
    }
    
}
