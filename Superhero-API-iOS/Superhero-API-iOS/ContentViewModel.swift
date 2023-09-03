//
//  ContentViewModel.swift
//  Superhero-API-iOS
//
//  Created by Guilherme Antonini on 03/09/23.
//

import Foundation
import SwiftUI

enum ViewState {
    case loaded
    case loading
    case idle
}

class ContentViewModel: ObservableObject {
    @Published var state: ViewState = .idle
    @Published var superhero: SuperheroModel = SuperheroModel()
    @Published var uiImage: UIImage = UIImage()
    
    @ObservedObject var service: APIService = APIService()
    
    func fetch(_ withSuperheroID: String) async throws {
        do {
            DispatchQueue.main.async {
                self.state = .loading
            }
            
            let superhero = try await service.fetchSuperhero(withSuperheroID)
            let uiImage = try await service.downloadImage(superhero.image.url)
            
            DispatchQueue.main.async {
                self.superhero = superhero
                self.uiImage = uiImage
                self.state = .loaded
            }
        } catch {
            throw error
        }
    }
}
