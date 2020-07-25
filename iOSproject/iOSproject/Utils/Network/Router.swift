//
//  Router.swift
//  iOSproject
//
//  Created by Gabriel Faria on 7/25/20.
//  Copyright © 2020 Gabriel Rodrigues. All rights reserved.
//

import Foundation

enum Router {
    
    case characters
    case singleCharacter
    
    enum idType: String {
        case characterId
        case comicId
    }
    
    static var currentId: [idType: Int] = [.characterId:0, .comicId:0]
    
    static let domain = "https://gateway.marvel.com"
    
    static let version = "/v1"
    
    static let pubkey = "92054aba8005e42d62aed24eee96198b"
    
    private var pvtkey : String {
        return "ae2000662c4b8c79870452c542c63dd907bb81a7"
    }
    
    static let timestamp = "randomtimpestamp"
    
    static var emptyUrl: String {
        return "\(Router.domain)\(Router.version)"
    }
    
    var url: String {
        return "\(Router.domain)\(Router.version)\(self.path)"
    }
    
    var path: String {
        switch self {
        case .characters: return "/public/characters"
        case .singleCharacter: return "/public/characters/\(Router.currentId[.characterId]!)"
        }
    }
    
    var method: HTTPMethod {
        switch self {
            case .characters: return .get
            case .singleCharacter: return .get
        }
    }
    
    func stringToHash() -> String {
        return "\(Router.timestamp+self.pvtkey+Router.pubkey)"
    }
}

enum HTTPMethod: String {
    case post = "POST"
    case get = "GET"
    case delete = "DELETE"
    case put = "PUT"
    case patch = "PATCH"
}
