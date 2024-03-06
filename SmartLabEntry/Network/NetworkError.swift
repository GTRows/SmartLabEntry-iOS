//
//  NetworkError.swift
//  SmartLabEntry
//
//  Created by Fatih Acıroğlu on 6.03.2024.
//

import Foundation

enum NetworkError: Error, LocalizedError {
    case invalidResponse
    case noData
    case decodingError
    case forbidden
    case unexpectedStatusCode(statusCode: Int, message: String)
    case unknown

    var errorDescription: String? {
        switch self {
        case .invalidResponse:
            return "Invalid response from the server."
        case .noData:
            return "No data received from the server."
        case .decodingError:
            return "Failed to decode data."
        case .forbidden:
            return "Access denied. You do not have permission to access this resource."
        case .unexpectedStatusCode(let statusCode, let message):
            return "Unexpected error occurred. Status Code: \(statusCode). Message: \(message)"
        case .unknown:
            return "An unknown error occurred."
        }
    }
}


