//
//  CharactersRoute.swift
//  RickAndMortyUIKit
//
//  Created by Casey Barth on 4/2/23.
//

import Foundation

enum CharactersRoute: Routable {
    case getCharacters
    case getCharacter(id: String)
    
    var path: String {
        switch self {
        case .getCharacters:
            return "https://rickandmortyapi.com/api/character"
        case .getCharacter(let id):
            return "https://rickandmortyapi.com/api/character/\(id)"
        }
    }
    
    var type: RequestType {
        return .get
    }
    
    var header: [String : String]? {
        return nil
    }
    
    var body: [String : String]? {
        return nil
    }
}
