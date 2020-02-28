//
//  APIError.swift
//  Training Task
//
//  Created by Veremey, Daniil on 2/26/20.
//  Copyright © 2020 Veremey, Daniil. All rights reserved.
//

import Foundation

enum APIError: Error {
    case invalidData
    case requestFailed
    case jsonConversionFailure
    case jsonParsingFailure
    case responseUnsuccessful
    case invalidDecoder
    
    var localizedDescription: String {
        switch self {
        case .invalidData:
            return "Invalid Data"
        case .requestFailed:
            return "Request Failed"
        case .jsonConversionFailure:
            return "JSON Conversion Failure"
        case .jsonParsingFailure:
            return "JSON Parsing Failure"
        case .responseUnsuccessful:
            return "Response Unsuccessful"
        case .invalidDecoder:
            return "Invalid Decoder"
            
        }
    }
}
