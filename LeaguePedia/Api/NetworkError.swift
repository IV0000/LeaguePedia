//
//  NetworkError.swift
//  LeaguePedia
//
//  Created by Ivan Voloshchuk on 11/07/22.
//

import Foundation

enum NetworkError: Error, CustomStringConvertible {
    case response(statusCode: Int)
    case badUrl
    case urlSession(URLError?)
    case parsing(DecodingError?)
    case undefined

    var userDescription: String {
        switch self {
        case .parsing, .badUrl, .undefined:
            return "Something went wrong"
        case .response:
            return "Connection failed"
        case let .urlSession(error):
            return error?.localizedDescription ?? "Something went wrong"
        }
    }

    // Debugging description
    var description: String {
        switch self {
        case let .parsing(error):
            return "parsing error: \(String(describing: error))"
        case .badUrl:
            return "wrong URL"
        case let .urlSession(error):
            return error?.localizedDescription ?? "Error URL session"
        case .undefined:
            return "unknown error"
        case let .response(statusCode: statusCode):
            return "response error with code: \(statusCode)"
        }
    }
}
