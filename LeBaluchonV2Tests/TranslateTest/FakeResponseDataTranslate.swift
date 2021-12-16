//
//  FakeResponseDataTranslate.swift
//  LeBaluchonV2Tests
//
//  Created by Nicolas Demange on 12/12/2021.
//

import Foundation

class FakeResponseDataTranslate {
    static let url: URL = URL(string: "https://api-free.deepl.com/v2/translate?text=Bienvenue&source_lang=FR&target_lang=EN&auth_key=0f32ec9e-5f6b-105c-721e-c587b6403638:fx")!

    static let responseOK = HTTPURLResponse(url: URL(string: "https://api-free.deepl.com/v2/translate?text=Bienvenue&source_lang=FR&target_lang=EN&auth_key=0f32ec9e-5f6b-105c-721e-c587b6403638:fx")!, statusCode: 200, httpVersion: nil, headerFields: nil)

    static let responseKO = HTTPURLResponse(url: URL(string: "https://api-free.deepl.com/v2/translate?text=Bienvenue&source_lang=FR&target_lang=EN&auth_key=0f32ec9e-5f6b-105c-721e-c587b6403638:fx")!, statusCode: 500, httpVersion: nil, headerFields: nil)

    class NetworkError: Error {}
    static let error = NetworkError()

    static var translateCorrectData: Data {
        let bundle = Bundle(for: FakeResponseDataTranslate.self)
        let url = bundle.url(forResource: "Translate", withExtension: "json")
        let data = try! Data(contentsOf: url!)
        return data
    }
    static let translateIncorrectData = "erreur".data(using: .utf8)!
}
