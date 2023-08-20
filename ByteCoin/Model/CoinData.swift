//
//  CoinData.swift
//  ByteCoin
//
//  Created by Anna Zaitsava on 21.08.23.
//

import Foundation

struct CoinData: Decodable {
    let time: String
    let rate: Double
    let asset_id_base: String
    let asset_id_quote: String
    
    
}
