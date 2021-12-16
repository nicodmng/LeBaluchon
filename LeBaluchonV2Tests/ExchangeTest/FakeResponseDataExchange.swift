//
//  FakeResponseDataExchange.swift
//  LeBaluchonV2Tests
//
//  Created by Nicolas Demange on 09/12/2021.
//

import Foundation

class FakeResponseDataExchange {
    static let url: URL = URL(string: "http://data.fixer.io/api/latest?access_key=2b1aed3ee194ffaad20c7989a8e58b7c&format=json")!

    static let responseOK = HTTPURLResponse(url: URL(string: "http://data.fixer.io/api/latest?access_key=2b1aed3ee194ffaad20c7989a8e58b7c&format=json")!, statusCode: 200, httpVersion: nil, headerFields: nil)

    static let responseKO = HTTPURLResponse(url: URL(string: "http://data.fixer.io/api/latest?access_key=2b1aed3ee194ffaad20c7989a8e58b7c&format=json")!, statusCode: 500, httpVersion: nil, headerFields: nil)

    class NetworkError: Error {}
    static let error = NetworkError()

    static var exchangeCorrectData: Data {
        let bundle = Bundle(for: FakeResponseDataExchange.self)
        let url = bundle.url(forResource: "Exchange", withExtension: "json")
        let data = try! Data(contentsOf: url!)
        return data
    }
    static let exchangeIncorrectData = "erreur".data(using: .utf8)!
}


