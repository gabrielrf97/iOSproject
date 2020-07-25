//
//  AllCharactersViewController.swift
//  iOSproject
//
//  Created by Gabriel Faria on 7/25/20.
//  Copyright © 2020 Gabriel Rodrigues. All rights reserved.
//

import UIKit

class AllCharactersViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        MarvelAPI.shared.fetchCharacters()
    }
}
