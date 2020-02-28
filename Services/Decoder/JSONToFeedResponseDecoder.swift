//
//  FeedResponseDecoder.swift
//  Training Task
//
//  Created by Veremey, Daniil on 2/26/20.
//  Copyright © 2020 Veremey, Daniil. All rights reserved.
//

import Foundation

class JSONToFeedResponseDecoder: ResponseDecoder<FeedModel?> {
    
    override func decode(response: HTTPURLResponse, from data: Data) throws -> FeedModel? {
        let feedData = try? JSONDecoder().decode(FeedModel.self, from: data)
        return feedData
    }
    
}
