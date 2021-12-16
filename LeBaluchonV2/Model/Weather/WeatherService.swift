//
//  WeatherService.swift
//  LeBaluchonV2
//
//  Created by Nicolas Demange on 18/11/2021.
//

import Foundation

class WeatherService {
    
    // MARK: - Let & Var
    private let session: URLSession
    
    init(session: URLSession = URLSession(configuration: .default)) {
        self.session = session
    }
    
    // MARK: - Functions
    func getWeather(callback: @escaping (Result<Welcome, NetworkError>) -> Void) {
        guard let url = URL(string: "https://api.openweathermap.org/data/2.5/group?id=2660645,5125771&units=metric&appid=0bceb223a70d5ead7d2f2a8b6b2ef09a") else { return }

        session.dataTaskHomeMade(with: url, callback: callback)
    }
}
