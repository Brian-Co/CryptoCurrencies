//
//  ViewController.swift
//  Crypto Currencies
//
//  Created by Brian Corrieri on 05/11/2019.
//  Copyright © 2019 FairTrip. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    private var viewModel: CurrenciesViewModel!
    
    var index = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.prefetchDataSource = self
        
        viewModel = CurrenciesViewModel(delegate: self)
        viewModel.getCurrencies()
    }
        
}

extension ViewController: UITableViewDelegate, UITableViewDataSource {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 400
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! TableViewCell
        
            if isLoadingCell(for: indexPath) {
                cell.configure(with: .none)
            } else {
                cell.configure(with: viewModel.cryptoCurrencies[indexPath.row])
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        index = indexPath.row
        self.performSegue(withIdentifier: "toDetails", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let vc = segue.destination as? CurrencyDetailsViewController {
            vc.currencyData = viewModel.cryptoCurrencies[index]
        }
        
    }
    
}

extension ViewController: UITableViewDataSourcePrefetching {
    
    func tableView(_ tableView: UITableView, prefetchRowsAt indexPaths: [IndexPath]) {
        if indexPaths.contains(where: isLoadingCell) {
            viewModel.getCurrencies()
        }
    }
    
}

extension ViewController: CurrenciesViewModelDelegate {
    
    func gotCurrencies(with newIndexPathsToReload: [IndexPath]?) {
        guard let newIndexPathsToReload = newIndexPathsToReload else {
          tableView.reloadData()
          return
        }
        let indexPathsToReload = visibleIndexPathsToReload(intersecting: newIndexPathsToReload)
        tableView.reloadRows(at: indexPathsToReload, with: .automatic)
    }
    
}

private extension ViewController {
    
  func isLoadingCell(for indexPath: IndexPath) -> Bool {
    return indexPath.row >= viewModel.currentCount
  }
  
  func visibleIndexPathsToReload(intersecting indexPaths: [IndexPath]) -> [IndexPath] {
    let indexPathsForVisibleRows = tableView.indexPathsForVisibleRows ?? []
    let indexPathsIntersection = Set(indexPathsForVisibleRows).intersection(indexPaths)
    return Array(indexPathsIntersection)
  }
    
}



