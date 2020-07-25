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
    
    func fetchCharacters(startsWith: String? = nil) {
        Network.shared.request(router: .characters, model: CharacterResponse.self, completion: { response in
            print(response)
        })
    }
    
    func fetchCharacter(id: Int) {
        Router.currentId[.characterId] = id
        Network.shared.request(router: .singleCharacter, model: Character.self, completion: { response in
            print(response)
        })
    }
}
