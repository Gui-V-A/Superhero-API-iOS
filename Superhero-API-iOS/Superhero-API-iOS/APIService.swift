//
//  APIService.swift
//  Superhero-API-iOS
//
//  Created by Guilherme Antonini on 03/09/23.
//

import Foundation
import SwiftUI

enum APIServiceError: Error, CustomStringConvertible {
    case urlError
    case httpResponseError
    case imageError
    case unknown
    
    public var description: String {
        switch self {
        case .urlError:
            return "URL Error"
        case .httpResponseError:
            return "HTTP Response Error"
        case .imageError:
            return "Image Error"
        case .unknown:
            return "Unknown Error"
        }
    }
}

class APIService: ObservableObject {
    private let apiKey: String
    private let apiURL: String
    
    init() {
        self.apiKey = "6057356621035697"
        self.apiURL = "https://superheroapi.com/api/\(apiKey)/"
    }
    
    func fetchSuperhero(_ withID: String) async throws -> SuperheroModel {
        let urlWithID = apiURL + withID
        
        guard let url = URL(string: urlWithID) else {
            throw APIServiceError.urlError
        }
        
        do {
            let (data, response) = try await URLSession.shared.data(from: url)
            
            guard let httpResponse = response as? HTTPURLResponse,
                  httpResponse.statusCode == 200 else {
                throw APIServiceError.httpResponseError
            }
            
            let superhero = try JSONDecoder().decode(SuperheroModel.self, from: data)
            return superhero
        } catch {
            throw error
        }
    }
    
    func downloadImage(_ fromString: String) async throws -> UIImage {
        guard let url = URL(string: fromString) else {
            throw APIServiceError.urlError
        }
        
        let (data, response) = try await URLSession.shared.data(from: url)
        
        guard let httpResponse = response as? HTTPURLResponse,
              httpResponse.statusCode == 200 else {
            throw APIServiceError.httpResponseError
        }
        
        guard let image = UIImage(data: data) else {
            throw APIServiceError.imageError
        }
        
        return image
    }
}
