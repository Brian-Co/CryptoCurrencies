//
//  CurrencyDetailsViewModel.swift
//  Crypto Currencies
//
//  Created by Brian Corrieri on 06/11/2019.
//  Copyright © 2019 FairTrip. All rights reserved.
//

import Foundation

protocol CurrencyDetailsViewModelDelegate: class {
    func didConvert(result: Double)
}


class CurrencyDetailsViewModel {

    private weak var delegate: CurrencyDetailsViewModelDelegate?
    
    init(delegate: CurrencyDetailsViewModelDelegate) {
      self.delegate = delegate
    }

    func convert(text: String?, currencyPrice: String) {
        if let nb = Double(text!) {
            let price = currencyPrice.replacingOccurrences(of: "€ ", with: "")
            let price2 = price.replacingOccurrences(of: ",", with: "")
            let priceDouble = Double(price2)!
            
            let conversion = nb / priceDouble
            delegate?.didConvert(result: conversion)
        }
        
    }
        
}
