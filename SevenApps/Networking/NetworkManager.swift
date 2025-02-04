//
//  NetworkManager.swift
//  SevenApps
//
//  Created by Ömer Firat on 4.02.2025.
//

import Alamofire

class NetworkManager {
    
    static let shared = NetworkManager()
    
    private init() {}
    
    // General request method, handles only successful responses
    func request<T: Decodable>(router: Router, completion: @escaping (Result<T, NetworkError>) -> Void) {
        
        // Alamofire Request
        AF.request(router)
            .validate(statusCode: 200..<300) // Accepting only 2xx response codes
            .responseDecodable(of: T.self) { response in
                
                // Check the response's result status
                switch response.result {
                case .success(let decodedResponse):
                    // Handle successful response
                    completion(.success(decodedResponse))
                    
                case .failure:
                    // Handle network error if failure
                    self.handleErrorResponse(response: response)
                    return
                }
            }
    }
    
    // Handle errors from response
    private func handleErrorResponse<T: Decodable>(response: AFDataResponse<T>) {
        guard let statusCode = response.response?.statusCode else {
            self.logError(message: "Unknown error occurred", statusCode: -1)
            return
        }
        
        // Determine client or server error based on status code
        switch statusCode {
        case 400...499:
            self.handleClientError(statusCode: statusCode)
        case 500...599:
            self.handleServerError(statusCode: statusCode)
        default:
            self.logError(message: "Unknown error occurred", statusCode: statusCode)
        }
    }
    
    // Handle client-side error (4xx status codes)
    private func handleClientError(statusCode: Int) {
        let errorMessage: String
        
        // Provide specific error messages based on status codes
        switch statusCode {
        case 400:
            errorMessage = "Bad Request: The server could not understand the request."
        case 401:
            errorMessage = "Unauthorized: Authentication is required and has failed."
        case 403:
            errorMessage = "Forbidden: The server understood the request, but it refuses to authorize it."
        case 404:
            errorMessage = "Not Found: The requested resource could not be found."
        default:
            errorMessage = "Client error occurred with status code: \(statusCode)"
        }
        
        self.logError(message: errorMessage, statusCode: statusCode)
    }
    
    // Handle server-side error (5xx status codes)
    private func handleServerError(statusCode: Int) {
        let errorMessage: String
        
        // Provide specific error messages based on status codes
        switch statusCode {
        case 500:
            errorMessage = "Internal Server Error: The server encountered an unexpected condition."
        case 502:
            errorMessage = "Bad Gateway: The server received an invalid response from the upstream server."
        case 503:
            errorMessage = "Service Unavailable: The server is currently unable to handle the request."
        default:
            errorMessage = "Server error occurred with status code: \(statusCode)"
        }
        
        self.logError(message: errorMessage, statusCode: statusCode)
    }
    
    // Log error messages for debugging
    private func logError(message: String, statusCode: Int) {
        // Here we log the error message
        print("ERROR - Status Code: \(statusCode), Message: \(message)")
        
        // In a real app, we could log the messages to a file or monitoring system
        // Logger.logError(message: message) // Example logging
    }
}

enum NetworkError: Error {
    case networkUnavailable(error: Error)
    case clientError(statusCode: Int)
    case serverError(statusCode: Int)
    case unknown(error: Error)
}
