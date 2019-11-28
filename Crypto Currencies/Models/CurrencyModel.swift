//
//  CurrencyModel.swift
//  Crypto Currencies
//
//  Created by Brian Corrieri on 05/11/2019.
//  Copyright © 2019 FairTrip. All rights reserved.
//

import Foundation


struct CryptoCurrencies: Codable {
    
    let Message: String
    let Data: [Data]
    
    struct Data: Codable {
        let CoinInfo: CoinInfo
        let DISPLAY: DISPLAY?
        
        
        struct CoinInfo: Codable {
            let FullName: String
            let ImageUrl: String
            
        }
        
        struct DISPLAY: Codable {
            let EUR: EUR
            
            struct EUR: Codable {
                let FROMSYMBOL: String
                let PRICE: String
                let VOLUME24HOUR: String
            }
            
        }
        
    }
    
}
