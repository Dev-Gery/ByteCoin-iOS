//
//  CoinManager.swift
//  ByteCoin
//
//  Created by Angela Yu on 11/09/2019.
//  Copyright © 2019 The App Brewery. All rights reserved.
//

import Foundation
import UIKit

struct CoinManager {
    var delegate: BitcoinDataDelegate?
    let baseURL = "https://rest.coinapi.io/v1/exchangerate/BTC"
    let apiKey = "B91F4D1F-E56A-4AA4-9F7A-3EE837263429"
    
    let currencyArray = ["AUD", "BRL","CAD","CNY","EUR","GBP","HKD","IDR","ILS","INR","JPY","MXN","NOK","NZD","PLN","RON","RUB","SEK","SGD","USD","ZAR"]
    
    func getCoinPrice(of index: Int) {
        let urlString = baseURL + "/\(currencyArray[index])" + "?apikey=\(apiKey)"
        if let url = URL(string: urlString) {
            let session = URLSession(configuration: .default)
            let task = session.dataTask(with: url) { data, response, error in
                if error != nil {
                    print(error!.localizedDescription)
                }
                else if let safeData = data {
                    if let exRate = self.parseJSON(safeData) {
                        DispatchQueue.main.async {
                            self.delegate?.getApiDidSuccess(rate: exRate.rate, curr: currencyArray[index])
                        }
                    }
                }
            }
            task.resume()
        }
    }
    
    func parseJSON(_ data: Data) -> BitcoinData? {
        let decoder = JSONDecoder()
        do {
            let decodedData = try decoder.decode(BitcoinData.self, from: data)
            return decodedData
        } catch {
            print(error)
            return nil
        }
    }

}
