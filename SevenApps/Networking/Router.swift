//
//  Router.swift
//  SevenApps
//
//  Created by Ömer Firat on 4.02.2025.
//
import Alamofire

// Base URL definition
struct API {
    static let baseURL = "https://jsonplaceholder.typicode.com"
    
    // A centralized function for headers
    static func defaultHeaders() -> HTTPHeaders {
        return [
            "Accept": "application/json",
            "Content-Type": "application/json"
        ]
    }
}

// Router Enum
enum Router: URLRequestConvertible {
    
    case getUsers
    
    // Implementing the URLRequestConvertible protocol
    func asURLRequest() throws -> URLRequest {
        
        // Getting the base URL
        let url = try API.baseURL.asURL()
        
        // Declaring the URLRequest object
        var request: URLRequest
        
        switch self {
        case .getUsers:
            // Construct the full URL by appending the path for getUsers
            request = URLRequest(url: url.appendingPathComponent(self.path()))
            // Set HTTP method to GET
            request.method = .get
            // Set timeout interval for the request
            request.timeoutInterval = 30
            // Add default headers (Accept and Content-Type)
            request.headers = API.defaultHeaders()
        }
        
        // Return the constructed URLRequest
        return request
    }
    
    // Returning the endpoint path
    private func path() -> String {
        switch self {
        case .getUsers:
            // Return path for 'getUsers' API endpoint
            return "/users"
        }
    }
}
