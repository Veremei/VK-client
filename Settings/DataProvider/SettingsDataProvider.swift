//
//  DataRequest.swift
//  Training Task
//
//  Created by Veremey, Daniil on 2/13/20.
//  Copyright © 2020 Veremey, Daniil. All rights reserved.
//

import Foundation
import Alamofire

class SettingsDataProvider {
    
    private var isFetchInProgress = false

    func getData(completion: @escaping (SettingsResponse?,Error?) -> ()) {
        guard !isFetchInProgress else { return }
        isFetchInProgress = true
        APIClient.shared.request(to: SettingsRoute.getRoute()) { [weak self] (result, error) in
            guard let self = self else { return }
            
            self.isFetchInProgress = false

            DispatchQueue.main.async {
                completion(result as? SettingsResponse, error)
            }
        }
    }
    
}
