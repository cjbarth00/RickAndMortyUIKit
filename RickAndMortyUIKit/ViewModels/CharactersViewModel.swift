//
//  CharactersViewModel.swift
//  RickAndMortyUIKit
//
//  Created by Casey Barth on 4/2/23.
//

import Foundation
import Combine
import RickAndMortyAPI

class CharactersViewModel: ObservableObject {
    private var client: APIClient
    @Published var characters: [Character] = []
    
    init(client: APIClient = APIClient()) {
        self.client = client
    }
    
    func requestCharacters() {
        Task {
            let paginatedResponse = await client.request(route: CharactersRoute.getCharacters, responseType: PaginatedResponse<Character>.self)
            
            switch paginatedResponse {
            case .failure(let error):
                print(error)
                
            case .success(let response):
                characters.append(contentsOf: response.results)
            }
        }
    }
}
