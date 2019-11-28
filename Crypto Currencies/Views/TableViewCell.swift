//
//  TableViewCell.swift
//  Crypto Currencies
//
//  Created by Brian Corrieri on 06/11/2019.
//  Copyright © 2019 FairTrip. All rights reserved.
//

import UIKit

class TableViewCell: UITableViewCell {
    
    @IBOutlet weak var logo: UIImageView!
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var symbol: UILabel!
    @IBOutlet weak var value: UILabel!
    

    override func awakeFromNib() {
        super.awakeFromNib()
        
        configure(with: .none)
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func configure(with currency: CryptoCurrencies.Data?) {
      if let currency = currency {
        name.text = currency.CoinInfo.FullName
        symbol.text = "Symbol: " + (currency.DISPLAY?.EUR.FROMSYMBOL ?? "Unknown")
        value.text = "Value: " + (currency.DISPLAY?.EUR.PRICE ?? "Unknown")
        logo.image = UIImage(named: "Bitcoin")
      }
    }

}
