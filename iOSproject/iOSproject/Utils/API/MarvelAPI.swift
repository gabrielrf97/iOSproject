//
//  MarvelAPI.swift
//  iOSproject
//
//  Created by Gabriel Faria on 7/25/20.
//  Copyright © 2020 Gabriel Rodrigues. All rights reserved.
//

import Foundation

class MarvelAPI {
    
    static let shared = MarvelAPI()
    
    private init() {}
    
    func fetchCharacters(startsWith name: String? = nil, completion: @escaping (Result<CharacterResponse, Error>) -> Void) {
        var parameters = Parameters()
        
        if let name = name {
            parameters["startsWith"] = name
        }
        
        Network.shared.request(router: .characters, parameters: parameters, model: CharacterResponse.self, completion: { response in
            completion(response)
        })
    }
    
    func fetchCharacter(id: Int, completion: @escaping (Result<CharacterResponse, Error>) -> ()) {
        Router.currentId[.characterId] = id
        Network.shared.request(router: .singleCharacter, model: CharacterResponse.self, completion: { response in
            completion(response)
        })
    }
}
