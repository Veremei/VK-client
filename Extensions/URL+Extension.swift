//
//  URL+Extension.swift
//  Training Task
//
//  Created by Veremey, Daniil on 2/18/20.
//  Copyright © 2020 Veremey, Daniil. All rights reserved.
//

import Foundation


extension URL {
    
    private func splitQuery(_ query: String) -> [String: [String]] {
        return query.components(separatedBy: "&").map { $0.components(separatedBy: "=") }.reduce(into: [String: [String]]()) { result, element in
            guard !element.isEmpty,
                let key = element[0].removingPercentEncoding,
                let value = element.count >= 2 ? element[1].removingPercentEncoding : "" else { return }
            var values = result[key, default: [String]()]
            values.append(value)
            result[key] = values
        }
    }
    
    var fragmentItems: [String: [String]] {
        guard let fragment = self.fragment else {
            return [:]
        }
        
        return splitQuery(fragment)
    }
    
    var queryItems: [String: [String]] {
        guard let query = self.query else {
            return [:]
        }
        
        return splitQuery(query)
    }
    
    
    func appendParameters( params: [String:Any]) -> URL? {
        var components = URLComponents(string: self.absoluteString)
        components?.queryItems = params.map { element in URLQueryItem(name: element.key, value: element.value as? String) }
        return components?.url
    }
    
}
