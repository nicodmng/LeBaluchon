//
//  TranslateService.swift
//  LeBaluchonV2
//
//  Created by Nicolas Demange on 25/11/2021.
//
import Foundation

class TranslateService {
    
    // MARK: - Let & Var
    
    private let session: URLSession
    
    init(session: URLSession = URLSession(configuration: .default)) {
        self.session = session
    }
    
    // MARK: - Functions
    func getTranslate(text: String, languageCodeTarget: String, callback: @escaping (Result<TranslateData, NetworkError>) -> Void) {
        guard let textEncoded = text.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed) else { return }
        guard let url = URL(string: "https://api-free.deepl.com/v2/translate?text=\(textEncoded)&source_lang=FR&target_lang=\(languageCodeTarget)&auth_key=0f32ec9e-5f6b-105c-721e-c587b6403638:fx") else { return }
        session.dataTaskHomeMade(with: url, callback: callback)
    }
}
