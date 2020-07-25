//
//  AllCharactersViewModel.swift
//  iOSproject
//
//  Created by Gabriel Faria on 7/25/20.
//  Copyright © 2020 Gabriel Rodrigues. All rights reserved.
//

import Foundation

struct CharacterViewModel {
    let name: String
    let imageUrl: String
    let id: Int
}

protocol AllCharactersViewDelegate: class {
    func show(error: String)
    func show(characters: [CharacterViewModel])
}

class AllCharactersViewModel {
    
    weak var delegate: AllCharactersViewDelegate?
    
    init() {}
    
    func fetchCharacters(withName name: String? = nil) {
        MarvelAPI.shared.fetchCharacters(startsWith: name) { response in
            switch response {
            case .success(let characters):
                let charactersViewModel = self.parse(response: characters)
                self.delegate?.show(characters: charactersViewModel)
            case .failure(let error):
                self.delegate?.show(error: error.localizedDescription)
            }
        }
    }
    
    private func parse(response: CharacterResponse) -> [CharacterViewModel] {
        let characters = response.data.results
        var charactersViewModel = [CharacterViewModel]()
        
        for character in characters {
            let characterViewModel = CharacterViewModel(name: character.name, imageUrl: character.pictureUrl ?? "", id: character.id)
            charactersViewModel.append(characterViewModel)
        }
        
        return charactersViewModel
    }
}
