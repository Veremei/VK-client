//
//  ResponseDecoder.swift
//  Training Task
//
//  Created by Veremey, Daniil on 2/26/20.
//  Copyright © 2020 Veremey, Daniil. All rights reserved.
//

import Foundation

public class ResponseDecoder<Result> {
    
    func decode(response: HTTPURLResponse, from data: Data) throws -> Result {
        return APIError.invalidData.localizedDescription as! Result
    }
    
}
