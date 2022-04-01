    //
    //  by: Tymek (iTmi) on: 31/03/2022 | ViewController.swift : NBP Exchange
    // Copyright (c) 2022, all rights reserved. UIID: 415F6328-AF6D-4A8E-BD8A-B7FBAAD9D526

import UIKit

class ExchangeCalculatorVC: UIViewController {
    
    @IBOutlet weak var amountToExchange: UITextField!
    @IBOutlet weak var currencyPicker: UIPickerView!
    
    @IBOutlet weak var exchangeAmount: UILabel!
    @IBOutlet weak var exchageRate: UILabel!
    @IBOutlet weak var exchangeValue: UILabel!
    
    @IBOutlet weak var RateDescriptionLabel: UILabel!
    @IBOutlet weak var ValueDescriptionLabel: UILabel!
    @IBOutlet weak var AmountDescriptionLabel: UILabel!
    
    var amount: Double = 0
    
    var rateToDouble : Double = 0
    
    var exchangeManager = ExchangeManager()
    let currencies = ["CAD","USD","EUR","GBP","HUF","CZK"]
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        exchangeManager.delegate = self
        currencyPicker.delegate = self
        amountToExchange.delegate = self
        
            // Do any additional setup after loading the view.
        RateDescriptionLabel.isHidden = true
        ValueDescriptionLabel.isHidden = true
        AmountDescriptionLabel.isHidden = true
        exchangeValue.isHidden = true
        exchageRate.isHidden = true
        exchangeAmount.isHidden = true
    }
    
}

extension ExchangeCalculatorVC: UITextFieldDelegate {
    func textFieldDidBeginEditing(_ textField: UITextField) {
        amountToExchange.placeholder = ""
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        if let value = textField.text {
            if Double(value) != nil {
                amount = Double(value)!
                AmountDescriptionLabel.isHidden = false
                AmountDescriptionLabel.text = "Amount:"
                exchangeAmount.isHidden = false
                exchangeValue.text = String(format: "%.2f",amount * rateToDouble)
            } else {
                textField.text = "Provide amount"
            }
        }
        textField.resignFirstResponder()
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if let value = textField.text {
            if Double(value) != nil {
                amount = Double(value)!
                exchangeAmount.text = String(amount)
            } else {
                textField.text = "Provide amount"
            }
        }
        textField.resignFirstResponder()
        return true
    }
}


extension ExchangeCalculatorVC: UIPickerViewDataSource, UIPickerViewDelegate {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return currencies.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return currencies[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        exchangeManager.checkCurrencies(for: currencies[row])
    }
    
    
}

extension ExchangeCalculatorVC : ExchangeManagerDelegate {
    func exchangeDetailsReceived(_ exchangeManager: ExchangeManager, exchange: CurrencyExchangeModel) {
        DispatchQueue.main.async { [self] in
            RateDescriptionLabel.isHidden = false
            ValueDescriptionLabel.isHidden = false
            exchageRate.isHidden = false
            exchangeValue.isHidden = false
            exchageRate.text = String(format: "%.2f", exchange.ask)
            rateToDouble = exchange.ask
            exchangeValue.text = String(format: "%.2f",rateToDouble * amount)
        }
    }
    
}

