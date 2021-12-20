//
//  NetworkError.swift
//  LeBaluchonV2
//
//  Created by Nicolas Demange on 08/12/2021.
//
import Foundation

enum NetworkError: Error {
    case noData, invalidResponse, undecodableData
}

extension NetworkError: CustomStringConvertible {
    var description: String {
        switch self {
        case .noData:
            return "Le service est momentanément indisponible"
        case .invalidResponse:
            return "Le service est momentanément indisponible"
        case .undecodableData:
            return "Le service est momentanément indisponible"
        }
    }
}
