//
//  FakeResponseDataWeather.swift
//  LeBaluchonV2Tests
//
//  Created by Nicolas Demange on 12/12/2021.
//

import Foundation

class FakeResponseDataWeather {
    static let url: URL = URL(string: "https://api.openweathermap.org/data/2.5/group?id=2660645,5125771&units=metric&appid=0bceb223a70d5ead7d2f2a8b6b2ef09a")!

    static let responseOK = HTTPURLResponse(url: URL(string: "https://api.openweathermap.org/data/2.5/group?id=2660645,5125771&units=metric&appid=0bceb223a70d5ead7d2f2a8b6b2ef09a")!, statusCode: 200, httpVersion: nil, headerFields: nil)

    static let responseKO = HTTPURLResponse(url: URL(string: "https://api.openweathermap.org/data/2.5/group?id=2660645,5125771&units=metric&appid=0bceb223a70d5ead7d2f2a8b6b2ef09a")!, statusCode: 500, httpVersion: nil, headerFields: nil)

    class NetworkError: Error {}
    static let error = NetworkError()

    static var weatherCorrectData: Data {
        let bundle = Bundle(for: FakeResponseDataWeather.self)
        let url = bundle.url(forResource: "Weather", withExtension: "json")
        let data = try! Data(contentsOf: url!)
        return data
    }
    static let weatherIncorrectData = "erreur".data(using: .utf8)!
}
