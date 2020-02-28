//
//  Double+Extension.swift
//  Training Task
//
//  Created by Veremey, Daniil on 2/17/20.
//  Copyright © 2020 Veremey, Daniil. All rights reserved.
//

import Foundation

extension Double {
    
    func getDateStringFromUTC() -> String {
        let date = Date(timeIntervalSince1970: self)
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale(identifier: "en_US")
        dateFormatter.dateStyle = .medium
        return dateFormatter.string(from: date)
    }
    
}
