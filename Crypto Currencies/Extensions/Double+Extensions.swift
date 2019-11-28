//
//  Double+Extensions.swift
//  Crypto Currencies
//
//  Created by Brian Corrieri on 06/11/2019.
//  Copyright © 2019 FairTrip. All rights reserved.
//

import Foundation

extension Double {
    func truncate(places : Int)-> Double {
        return Double(floor(pow(10.0, Double(places)) * self)/pow(10.0, Double(places)))
    }
}
