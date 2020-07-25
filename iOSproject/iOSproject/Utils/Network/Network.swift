//
//  Network.swift
//  iOSproject
//
//  Created by Gabriel Faria on 7/25/20.
//  Copyright © 2020 Gabriel Rodrigues. All rights reserved.
//

import Foundation
import CommonCrypto

typealias Parameters = [String: String]

class Network {
    
    static let shared = Network()
    
    private init() {}
    
    func request<T: Decodable>(router: Router, parameters: Parameters? = nil, model: T.Type, completion: @escaping (Result<T,Error>) -> () ) {
        
        guard var components = URLComponents(string: router.url) else {
            return
        }
        
        components.queryItems = [URLQueryItem]()
        
        if let parameters = parameters {
            components.queryItems = parameters.map { (key, value) in
                return URLQueryItem(name: key, value: value)
            }
        }
        
        appendAuthParameters(&components)
        
        let request = URLRequest(url: components.url!)
        URLSession.shared.dataTask(with: request) { data, response, error in
            do {
                if let data = data {
                    let response = try JSONDecoder().decode(model, from: data)
                    completion(.success(response))
                } else if let error = error {
                    completion(.failure(error))
                }
            } catch {
                completion(.failure(error))
            }
            
        }.resume()
    }
    
    private func appendAuthParameters(_ components: inout URLComponents) {
        components.queryItems?.append(URLQueryItem(name: "apikey", value: Router.pubkey))
        components.queryItems?.append(URLQueryItem(name: "ts", value: Router.timestamp))
        components.queryItems?.append(URLQueryItem(name: "hash", value: generateMD5(Router.stringToHash(.characters)())))
    }
    
    private func generateMD5(_ string: String) -> String? {
        let length = Int(CC_MD5_DIGEST_LENGTH)
        var digest = [UInt8](repeating: 0, count: length)

        if let d = string.data(using: String.Encoding.utf8) {
            _ = d.withUnsafeBytes { (body: UnsafePointer<UInt8>) in
                CC_MD5(body, CC_LONG(d.count), &digest)
            }
        }

        return (0..<length).reduce("") {
            $0 + String(format: "%02x", digest[$1])
        }
    }
}
