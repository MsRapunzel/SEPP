//
//  NetworkManager.swift
//  CryptoiOS
//
//  Created by Anastasiia Zolotova on 24.04.2024.
//

import Foundation
import Combine

/// Manager for sending requests to GeckoAPI and handling any occuring errors.
class NetworkingManager {
    
    /// Enum representing possible errors during networking operations.
    enum NetworkingError: LocalizedError {
        case badURLResponse(url: URL)
        case unknown
        case tooManyRequests(url: URL)
        
        /// Provides a human-readable description of the error.
        var errorDescription: String? {
            switch self {
            case .badURLResponse(url: let url): return "[🔥] Bad response from URL: \(url)"
            case .unknown: return "[⚠️] Unknown error occured"
            case .tooManyRequests(url: let url): return "[🥲] Too many requests at URL: \(url)"
            }
        }
    }
    
    /// Downloads data from the given URL.
    ///
    /// - Parameter url: The URL to download data from.
    /// - Returns: A publisher emitting the downloaded data or an error.
    /// ```
    /// This method uses `URLSession` to create a data task publisher, maps the response to data if the response is valid,
    /// and handles errors appropriately.
    /// ```
    static func download(url: URL) -> AnyPublisher<Data, Error> {
        return URLSession.shared.dataTaskPublisher(for: url)
            .tryMap({ try handleURLResponse(output: $0, url: url) })
            .receive(on: DispatchQueue.main)
            .eraseToAnyPublisher()
    }
    
    /// Handles the URL response, validating the HTTP status code.
    ///
    /// - Parameters:
    ///   - output: The output from the URL session data task publisher.
    ///   - url: The URL from which the response was received.
    /// - Returns: The data if the response is valid.
    /// - Throws: A `NetworkingError` if the response is invalid.
    /// ```
    /// This method checks if the response is a valid `HTTPURLResponse` and validates the status code.
    /// If the status code is 200, it returns the data. If the status code is 429, it throws a `tooManyRequests` error.
    /// For other status codes, it throws a `badURLResponse` error.
    /// ```
    static func handleURLResponse(output: URLSession.DataTaskPublisher.Output, url: URL) throws -> Data {
        guard let response = output.response as? HTTPURLResponse else {
            throw NetworkingError.badURLResponse(url: url)
        }

        switch response.statusCode {
        case 200:
            return output.data
        case 429:
            throw NetworkingError.tooManyRequests(url: url)
        default:
            throw NetworkingError.badURLResponse(url: url)
        }
    }
    
    /// Handles the completion of a publisher.
    ///
    /// - Parameter completion: The completion status of the publisher.
    /// ```
    /// This method handles the completion of the publisher by printing the localized description of the error if the completion
    /// is a failure.
    /// ```
    static func handleCompletion(completion: Subscribers.Completion<Error>) {
        switch completion {
        case .finished:
            break
        case .failure(let error):
            print(error.localizedDescription)
        }
    }
    
}
