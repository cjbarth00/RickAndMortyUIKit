//
//  APIService.swift
//  RickAndMortyUIKit
//
//  Created by Casey Barth on 4/2/23.
//

import Foundation

enum APIErrors: Error {
    case failedToGetPath
    case failedToGetValidResponse
    case failedToDecode
    case serverError(statusCode: Int)
}

struct APIClient {
    func request<T: Decodable>(route: Routable, responseType: T.Type) async -> Result<T, Error> {
        guard let url = URL(string: route.path) else { return .failure(APIErrors.failedToGetPath) }
        
        var request = URLRequest(url: url)
        request.httpMethod = route.type.rawValue
        request.allHTTPHeaderFields = route.header
        
        do {
            let (data, response) = try await URLSession.shared.data(for: request)
            guard let response = response as? HTTPURLResponse else {
                return .failure(APIErrors.failedToGetValidResponse)
            }
            
            // Validate data response status code
            switch response.statusCode {
            case 200..<300:
                guard let decodedResponse = try? JSONDecoder().decode(responseType, from: data) else {
                    return .failure(APIErrors.failedToDecode)
                }
                return .success(decodedResponse)
            default:
                return .failure(APIErrors.serverError(statusCode: response.statusCode))
            }
            
        } catch {
            return .failure(error)
        }
    }
}


/*
 Components of a request
 
 URLSession
 URLRequest - contains url, http method, headers, data
 
 The request:
 try await URLSession.shared.data(for: URLRequest)
 
 decoding:
 JSONDecoder().decode(type: T.Type, from: Data
 
 encoding:
 JSONEn
 */
