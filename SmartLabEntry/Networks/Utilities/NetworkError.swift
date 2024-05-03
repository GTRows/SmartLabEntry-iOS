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
    case unauthorized
    case badRequest(statusCode: Int, message: String)
    case forbidden
    case notFound
    case serverError
    case unexpectedStatusCode(statusCode: Int)
    case errorMessages(statusCode: Int, message: String)
    case unknown

    var statusCode: Int {
        switch self {
        case .unauthorized:
            return 401
        case .forbidden:
            return 403
        case .notFound:
            return 404
        case .serverError:
            return 500
        case let .errorMessages(statusCode, _),
             let .badRequest(statusCode, _),
             let .unexpectedStatusCode(statusCode):
            return statusCode
        default:
            return 0
        }
    }

    var errorDescription: String? {
        switch self {
        case .invalidResponse:
            return "Invalid response from the server."
        case .noData:
            return "No data received from the server."
        case .decodingError:
            return "Failed to decode data."
        case .unauthorized:
            return "Unauthorized. Authentication is required and has failed or has not yet been provided."
        case .forbidden:
            return "Forbidden. You do not have permission to access this resource."
        case .notFound:
            return "Not Found. The requested resource could not be found."
        case .serverError:
            return "Internal Server Error. A generic error message, given when an unexpected condition was encountered."
        case let .unexpectedStatusCode(statusCode):
            return "Unexpected HTTP status code received: \(statusCode)."
        case let .errorMessages(_, message),
             let .badRequest(_, message):
            return "\(message)"
        default:
            return "An unknown error occurred."
        }
    }
}
