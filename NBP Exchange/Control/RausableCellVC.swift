//
//  by: Tymek (iTmi) on: 29/04/2022 | RausableCellVC.swift : NBP Exchange 
// Copyright (c) 2022, all rights reserved. UIID: 5060E226-0671-40AE-9767-0C26137795F5 

import UIKit

class RausableCellVC: UITableViewCell {

    @IBOutlet weak var CodeLabel: UILabel!
    @IBOutlet weak var ExchangeLabel: UILabel!
    @IBOutlet weak var DescriptionLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
