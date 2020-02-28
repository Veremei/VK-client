//
//  DataProviderProtocol.swift
//  Training Task
//
//  Created by Veremey, Daniil on 2/19/20.
//  Copyright © 2020 Veremey, Daniil. All rights reserved.
//

import Foundation

enum FetchSource {
    case network
    case offline
}

protocol DataProviderProtocol : class {
    func didFetchData(updated: Bool, fetchSource: FetchSource)
    func didFailWithError(error: String)
}
