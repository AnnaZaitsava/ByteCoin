//
//  CoinManager.swift
//  ByteCoin
//
//  Created by Anna Zaitsava on 20.08.23.
//

import Foundation

protocol CoinManagerDelegate {
    
 func didUpdateRate(currency: String, rate: String)
    func didFailWithError(error: Error)
}

struct CoinManager {
    
    var delegate: CoinManagerDelegate?
    
    let baseURL = "https://rest.coinapi.io/v1/exchangerate/BTC"
    let apiKey = "1F104EFA-079A-4420-B56F-D5F826C31394"
    
    let currencyArray = ["AUD", "BRL","CAD","CNY","EUR","GBP","HKD","IDR","ILS","INR","JPY","MXN","NOK","NZD","PLN","RON","RUB","SEK","SGD","USD","ZAR"]
    
    func getCoinPrice(for currency: String) {
        
        let urlString = "\(baseURL)/\(currency)?apikey=\(apiKey)"
        
        if let url = URL(string: urlString) {
            
            let session = URLSession(configuration: .default)
            
            let task = session.dataTask(with: url) { (data, response, error) in
                if error != nil {
                    self.delegate?.didFailWithError(error: error!)
                    return
                }
                
                if let safeData = data {
                    if let bitcoinLastPrice = self.parseJSON(safeData) {
                        
                        let rateAsString =
                        String(format: "%.2f", bitcoinLastPrice)
                        
                        self.delegate?.didUpdateRate(currency: currency, rate: rateAsString)
                    }
                }
            }
                
                task.resume()
            }
        }
    
    func parseJSON(_ data: Data) -> Double? {
        let decoder = JSONDecoder()
        do {
            let decodedData = try  decoder.decode(CoinData.self, from: data)
            
            let lastPrice = decodedData.rate
            print(lastPrice)
            return lastPrice
            
        } catch {
            delegate?.didFailWithError(error: error)
            return nil
        }
    }
}
