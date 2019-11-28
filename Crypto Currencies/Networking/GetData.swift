//
//  GetData.swift
//  Crypto Currencies
//
//  Created by Brian Corrieri on 06/11/2019.
//  Copyright © 2019 FairTrip. All rights reserved.
//

import Foundation

class GetData {
    
    func getData(urlString: String, completion: @escaping (Data?) -> ()) {
        
        guard let url = URL(string: urlString) else {
            print("Error: cannot create URL")
            return completion(nil)
        }
        let urlRequest = URLRequest(url: url)
        
        let config = URLSessionConfiguration.default
        let session = URLSession(configuration: config)
        
        let task = session.dataTask(with: urlRequest) {
            (data, response, error) in
            guard error == nil else {
                print("error calling getData")
                print(error!)
                return completion(nil)
            }
            
            guard let responseData = data else {
                print("Error: did not receive data")
                return completion(nil)
            }
            
            return completion(responseData)
        }
        task.resume()
        
    }
    
    
}
