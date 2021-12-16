//
//  TranslateData.swift
//  LeBaluchonV2
//
//  Created by Nicolas Demange on 25/11/2021.
//

import Foundation

// MARK: - Welcome
struct TranslateData: Decodable {
    let translations: [Translation]
}

// MARK: - Translation
struct Translation: Decodable {
    let detectedSourceLanguage, text: String

    enum CodingKeys: String, CodingKey {
        case detectedSourceLanguage = "detected_source_language"
        case text
    }
}
