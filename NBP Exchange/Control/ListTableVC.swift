    //
    //  by: Tymek (iTmi) on: 26/04/2022 | ListTableVC.swift : NBP Exchange
    // Copyright (c) 2022, all rights reserved. UIID: D224C139-D989-4698-BB42-92852D75C2CE

import UIKit

class ListTableVC: UITableViewController {
    
    var exchangeManager = ExchangeManager()
    
    var arrayOfRates = [Rates]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
            // Uncomment the following line to preserve selection between presentations
            // self.clearsSelectionOnViewWillAppear = false
        exchangeManager.delegate = self
        exchangeManager.fetchExchangedRates()
            // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
            // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }
    
        // MARK: - Table view data source
    
    override func numberOfSections(in tableView: UITableView) -> Int {
            // #warning Incomplete implementation, return the number of sections
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            // #warning Incomplete implementation, return the number of rows
        return arrayOfRates.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let reusableCell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as? RausableCellVC else { return UITableViewCell()}
        let cellData = arrayOfRates[indexPath.row]
        
        reusableCell.CodeLabel.text = cellData.code
        reusableCell.ExchangeLabel.text = String(format: "%.2f", cellData.mid)
        reusableCell.DescriptionLabel.text = cellData.currency
        return reusableCell
    }
    
}

extension ListTableVC : ExchangeManagerDelegate {
    func didUpdateExchangeArray(_ exchangeManager: ExchangeManager, received: ExchangeRates) {
        DispatchQueue.main.async { [self] in
            let newElementsArray = received.rates
            arrayOfRates = newElementsArray
            print(arrayOfRates)
            arrayOfRates.sort { $0.code < $1.code}
            
            print("\(#function) : \(arrayOfRates.count)")
            tableView.reloadData()
        }
    }
}
