//
//  Connectivity.swift
//  Training Task
//
//  Created by Veremey, Daniil on 2/19/20.
//  Copyright © 2020 Veremey, Daniil. All rights reserved.
//

import Foundation
import Alamofire

class Connectivity {
    class var isConnected:Bool {
        return NetworkReachabilityManager()!.isReachable
    }
}
