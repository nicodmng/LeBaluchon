//
//  ExchangeRate.swift
//  LeBaluchonV2
//
//  Created by Nicolas Demange on 17/11/2021.
//

import Foundation

struct ExchangeRate: Decodable {
    let rates: [String: Double]
}


