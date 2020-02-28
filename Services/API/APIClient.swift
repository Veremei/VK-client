//
//  APIClient.swift
//  Training Task
//
//  Created by Veremey, Daniil on 2/26/20.
//  Copyright © 2020 Veremey, Daniil. All rights reserved.
//

import Alamofire

class APIClient {
    
    static let shared = APIClient()
    
    private init() {}
    
    public func request<Result>(to route: APIRoute<Result>, completion: @escaping (_ data: Result?, _ err: Error?) -> ()){
        
        let url = (route.url == nil) ? ConfigurationService.shared.baseURL : route.url
        let parameters = route.parameters
        
        let queue = DispatchQueue(label: url!, qos: .background)
        
        Alamofire.request(url!, method: route.method, parameters: parameters , encoding: route.encoding, headers: nil).responseString(queue: queue)  { (response) in
            
            if let status = response.response?.statusCode, status == 200 {
                
                do {
                    let result = try route.decoder.decode(response: response.response!, from: response.data!)
                    DispatchQueue.main.async {
                        completion(result, nil)
                    }
                    
                } catch {
                    DispatchQueue.main.async {
                        completion(nil, APIError.invalidDecoder)
                    }
                }
                
            } else if let error = response.result.error as? AFError {
                
                DispatchQueue.main.async {
                    completion(nil, error)
                }
                
            } else if let error = response.result.error as? URLError {
                
                DispatchQueue.main.async {
                    completion(nil, error)
                }
                
            } else {
                
                DispatchQueue.main.async {
                    completion(nil, response.result.error)
                }
            }
            
        }
    }
    
}
