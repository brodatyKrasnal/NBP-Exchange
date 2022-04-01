    //
    //  by: Tymek (iTmi) on: 31/03/2022 | ExchangeManager.swift : NBP Exchange
    // Copyright (c) 2022, all rights reserved. UIID: 0383033F-928F-43A0-8490-221A3DC66E3C

import Foundation

protocol ExchangeManagerDelegate {
    func exchangeDetailsReceived( _ exchangeManager: ExchangeManager, exchange: CurrencyExchangeModel)
}

struct ExchangeManager {
    var delegate : ExchangeManagerDelegate?

    
    func checkCurrencies (for code: String) {
        let url = URL(string:"https://api.nbp.pl/api/exchangerates/rates/c/\(code)/?format=json")!
        let session = URLSession(configuration: .default)
        let task = session.dataTask(with: url) { data, response, error in
            
            if let checkError = error {
                print(checkError.localizedDescription)
            }
            if let receivedData = data {
                if let exchange = self.parseJSON(dataset: receivedData) {
                    delegate?.exchangeDetailsReceived(self, exchange: exchange)
                }
            }
        }
        task.resume()
    }
    
    func parseJSON (dataset: Data)  -> CurrencyExchangeModel? {
        let decoder  = JSONDecoder()
        
        do {
            let decodedData =  try decoder.decode(ExchangeModel.self, from: dataset)
            let exchangeSet = CurrencyExchangeModel(
                currencyDescription: decodedData.currency,
                currencyCode: decodedData.code,
                bid: decodedData.rates[0].bid!,
                ask: decodedData.rates[0].ask!)
            print(exchangeSet)
            return exchangeSet
        } catch {
            print(error)
            return nil
        }
    }
    
}

struct CurrencyExchangeModel {
    let currencyDescription : String
    let currencyCode : String
    let bid : Double
    let ask : Double
    
    var askString : String {
        return String(format: "%.2f",ask)
    }
    
}

struct ExchangeModel : Codable {
    let table : String
    let currency : String
    let code : String
    let rates : [Rates]
}

struct Rates : Codable {
    let no : String?
    let effectiveDate : String?
    let bid : Double?
    let ask : Double?
}


