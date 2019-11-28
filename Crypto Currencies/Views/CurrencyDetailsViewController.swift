//
//  CurrencyDetailsViewController.swift
//  Crypto Currencies
//
//  Created by Brian Corrieri on 06/11/2019.
//  Copyright © 2019 FairTrip. All rights reserved.
//

import Foundation
import UIKit

class CurrencyDetailsViewController: UIViewController {
    
    @IBOutlet weak var logo: UIImageView!
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var symbol: UILabel!
    @IBOutlet weak var price: UILabel!
    @IBOutlet weak var volumeOver24h: UILabel!
    @IBOutlet weak var textField: UITextField!
    @IBOutlet weak var conversionResult: UILabel!
    @IBOutlet weak var convertButton: UIButton!
    
    var currencyData: CryptoCurrencies.Data?
    
    private var viewModel: CurrencyDetailsViewModel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        hideKeyboardOnTap()
        convertButton.layer.cornerRadius = 12
        
        if let currencyData = self.currencyData {
            name.text = currencyData.CoinInfo.FullName
            symbol.text = "Symbol: " + (currencyData.DISPLAY?.EUR.FROMSYMBOL ?? "Unknown")
            price.text = "Price: " + (currencyData.DISPLAY?.EUR.PRICE ?? "Unknown")
            volumeOver24h.text = "Volume over 24h:\n" + (currencyData.DISPLAY?.EUR.VOLUME24HOUR ?? "Unknown")
        }
        
        viewModel = CurrencyDetailsViewModel(delegate: self)
        
    }
    
    @IBAction func convertButtonPressed(_ sender: Any) {
        self.view.endEditing(true)
        viewModel.convert(text: textField.text, currencyPrice: currencyData!.DISPLAY?.EUR.PRICE ?? "0")
    }
    
}

extension CurrencyDetailsViewController: CurrencyDetailsViewModelDelegate {
    
    func didConvert(result: Double) {
        conversionResult.text = "I will have \(result.truncate(places: 2)) of \(currencyData!.CoinInfo.FullName)"
    }
    
}

