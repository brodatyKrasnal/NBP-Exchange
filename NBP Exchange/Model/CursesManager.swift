//
//  by: Tymek (iTmi) on: 31/03/2022 | CursesManager.swift : NBP Exchange
// Copyright (c) 2022, all rights reserved. UIID: 0DDC1670-CC2D-4803-BA05-978913466289

import Foundation

struct CursesManager {
    
    var tableArray = [Rates]()
    
    func fetchCurses(with table: Character) {
        let url = URL(string: "https://api.nbp.pl/api/exchangerates/tables/\(table)/?format=json")
        let session = URLSession(configuration: .default)
        let task = session.dataTask(with: url!) { data, response, error in
            if let fail = error {
                print(fail.localizedDescription)
            }
            
            if let receivedData = data {
                parseJSON(receivedData)
                
            }
        }
        task.resume()
        
    }
    
    func parseJSON (_ exchangeData : Data) {
        let decoder = JSONDecoder ()
        do {
            let decodedData = try decoder.decode(CursesModel.self, from: exchangeData)
            let cursesSet = CursesModel(table: decodedData.table, code: decodedData.code, no: decodedData.no, effectiveDate: decodedData.no, rates: decodedData.rates)
            print(cursesSet.rates)
        } catch{
            print(error.localizedDescription)
        }
        
    }
}

struct CursesModel : Codable {
    let table : String
    let code : String
    let no : String
    let effectiveDate : String
    let rates : [Rates]
}
