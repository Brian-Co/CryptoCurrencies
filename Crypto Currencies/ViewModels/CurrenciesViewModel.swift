//
//  CurrenciesViewModel.swift
//  Crypto Currencies
//
//  Created by Brian Corrieri on 06/11/2019.
//  Copyright © 2019 FairTrip. All rights reserved.
//

import Foundation


protocol CurrenciesViewModelDelegate: class {
    func gotCurrencies(with newIndexPathsToReload: [IndexPath]?)
}

class CurrenciesViewModel {
    
    private weak var delegate: CurrenciesViewModelDelegate?
    
    init(delegate: CurrenciesViewModelDelegate) {
      self.delegate = delegate
    }
    
    var cryptoCurrencies: [CryptoCurrencies.Data] = []
    let client = GetData()
    let decoder = Decode()
    private var isFetchInProgress = false
    private var currentPage = 0
    
    var currentCount: Int {
        return cryptoCurrencies.count
    }
    
    func getCurrencies() {
                
        guard !isFetchInProgress else {
            return
        }
        
        isFetchInProgress = true
        
        let userDefaults = UserDefaults.standard
        if let data = userDefaults.value(forKey: "Data" + "\(currentPage)") as? Data {
            self.isFetchInProgress = false
            if let cryptoCurrencies = decoder.decodeJSON(data: data) {
                self.cryptoCurrencies.append(contentsOf: cryptoCurrencies.Data)
                self.currentPage += 1
                print("gotData userDefaults \(cryptoCurrencies.Data[0].CoinInfo.FullName) count \(self.cryptoCurrencies.count)")
                if currentPage - 1 > 0 {
                    let indexPathsToReload = self.calculateIndexPathsToReload(from: self.cryptoCurrencies)
                    self.delegate?.gotCurrencies(with: indexPathsToReload)
                } else {
                    self.delegate?.gotCurrencies(with: .none)
                }
            }
        } else {
            client.getData(urlString: "https://min-api.cryptocompare.com/data/top/mktcapfull?limit=20&page=" + "\(currentPage)" + "&tsym=EUR") { data in
                self.isFetchInProgress = false
                if let data = data {
                    userDefaults.set(data, forKey: "Data" + "\(self.currentPage)")
                    if let cryptoCurrencies = self.decoder.decodeJSON(data: data) {
                        self.cryptoCurrencies.append(contentsOf: cryptoCurrencies.Data)
                        self.currentPage += 1
                        print("gotData \(cryptoCurrencies.Data[0].CoinInfo.FullName) count \(self.cryptoCurrencies.count)")
                        DispatchQueue.main.async {
                            if self.currentPage - 1 > 0 {
                                let indexPathsToReload = self.calculateIndexPathsToReload(from: self.cryptoCurrencies)
                                self.delegate?.gotCurrencies(with: indexPathsToReload)
                            } else {
                                self.delegate?.gotCurrencies(with: .none)
                            }
                        }
                    }
                } else {
                    self.isFetchInProgress = false
                }
            }
        }
        
    }
    
        
    private func calculateIndexPathsToReload(from newCurrencies: [CryptoCurrencies.Data]) -> [IndexPath] {
      let startIndex = cryptoCurrencies.count - newCurrencies.count
      let endIndex = startIndex + newCurrencies.count
      return (startIndex..<endIndex).map { IndexPath(row: $0, section: 0) }
    }
    
}
