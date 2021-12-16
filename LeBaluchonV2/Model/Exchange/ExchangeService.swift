//
//  ExchangeService.swift
//  LeBaluchonV2
//
//  Created by Nicolas Demange on 17/11/2021.
//

import Foundation

class ExchangeService {
    
    // MARK: - Let & Var
    private let session: URLSession

    init(session: URLSession = URLSession(configuration: .default)) {
        self.session = session
    }
    
    // MARK: - Functions
    func getExchange(callback: @escaping (Result<ExchangeRate, NetworkError>) -> Void) {
        guard let url = URL(string: "http://data.fixer.io/api/latest?access_key=2b1aed3ee194ffaad20c7989a8e58b7c&format=json") else { return }
        session.dataTaskHomeMade(with: url, callback: callback)
    }
}
