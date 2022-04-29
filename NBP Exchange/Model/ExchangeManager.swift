    //
    //  by: Tymek (iTmi) on: 31/03/2022 | ExchangeManager.swift : NBP Exchange
    // Copyright (c) 2022, all rights reserved. UIID: 0383033F-928F-43A0-8490-221A3DC66E3C

import Foundation

protocol ExchangeManagerDelegate {
    func didUpdateExchangeArray (_ exchangeManager: ExchangeManager, received: ExchangeRates)
}

struct ExchangeManager {
    
    var delegate : ExchangeManagerDelegate?
    
    func fetchExchangedRates () {
        for letter in ["A","B"] {
            let url = "https://api.nbp.pl/api/exchangerates/tables/\(letter)/?format=json"
            
            URLSession.shared.dataTask(with: URL(string: url)!) { data, _ , erorr in
                
                if let failure = erorr { print(failure.localizedDescription) }
                
                if let receivedData = data {
                   // print("API rerutned data.")
                    if let courses = parseFreackingJSON(from: receivedData) {
                       // print("Courses: \(courses)")
                        delegate?.didUpdateExchangeArray(self, received: courses)
                    }
                    print("data from table\(letter)")
                }
        
            }.resume()
        }
        
    }
    
    func parseFreackingJSON (from data: Data)  -> ExchangeRates? {
        
        let decoder = JSONDecoder()
        do {
            let decodedData = try decoder.decode([ExchangeRates].self, from: data)
            let receivedData = ExchangeRates(rates: decodedData[0].rates)
            //print("data from JSON : \(receivedData.rates[0].code)")
            return receivedData
        } catch {
            print(error)
        }
        return nil
    }
    
}

struct ExchangeRates : Codable {
    let rates : [Rates]
}

struct Rates : Codable, Hashable {
    let currency : String
    let code : String
    let mid : Double
}
