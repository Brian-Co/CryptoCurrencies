//
//  Decode.swift
//  Crypto Currencies
//
//  Created by Brian Corrieri on 06/11/2019.
//  Copyright © 2019 FairTrip. All rights reserved.
//

import Foundation
import UIKit

class Decode {
    
    func decodeJSON(data: Data) -> CryptoCurrencies? {
        let decoder = JSONDecoder()
        let currencies = try? decoder.decode(CryptoCurrencies.self, from: data)
        
        if let currencies = currencies {
            return currencies
        } else {
            return nil
        }
    }
    
    func decodeImage(data: Data) -> UIImage? {
        guard let image = UIImage(data: data) else {
            print("Error: did not convert data")
            return nil
        }
        return image
    }
    
    
}
