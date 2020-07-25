//
//  AllCharactersViewController.swift
//  iOSproject
//
//  Created by Gabriel Faria on 7/25/20.
//  Copyright © 2020 Gabriel Rodrigues. All rights reserved.
//

import UIKit

class AllCharactersViewController: UIViewController {
    
    var collectionView: UICollectionView!
    var searchBar: UISearchBar!
    
    var cellWidth = UIScreen.main.bounds.width / 2.5
    var cellHeight = UIScreen.main.bounds.height / 4
    var itemSpacing = UIScreen.main.bounds.width / 15
    var lineSpacing = UIScreen.main.bounds.height / 25
    
    var viewModel = AllCharactersViewModel()
    let characterId = "characterIconCell"
    
    var characters = [CharacterViewModel]() {
        didSet {
            DispatchQueue.main.async {
                self.collectionView.reloadData()
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        viewModel.delegate = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        viewModel.fetchCharacters()
    }
}

extension AllCharactersViewController: ViewCode {
    func createSubviews() {
        
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        
        collectionView = UICollectionView(frame: view.frame, collectionViewLayout: layout)
        collectionView.delegate = self
        collectionView.backgroundColor = .blue
        collectionView.dataSource = self
        collectionView.allowsSelection = true
        collectionView.register(CharacterIconCell.self, forCellWithReuseIdentifier: characterId)
        view.addSubview(collectionView)
        
        searchBar = UISearchBar()
        searchBar.barStyle = .default
        searchBar.delegate = self
        view.addSubview(searchBar)
    }
    
    func createConstraints() {
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: view.topAnchor, constant: 120),
            collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
        ])
        
        searchBar.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            searchBar.topAnchor.constraint(equalTo: view.topAnchor),
            searchBar.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            searchBar.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            searchBar.heightAnchor.constraint(equalToConstant: 44),
        ])

    }
}

extension AllCharactersViewController: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {

    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return characters.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: characterId, for: indexPath) as? CharacterIconCell else {
            return UICollectionViewCell()
        }
        
        let character = characters[indexPath.row]
        cell.configure(name: character.name, imageUrl: character.imageUrl)
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: cellWidth, height: cellHeight)
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return itemSpacing
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
         return lineSpacing
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        let verticalInset =  collectionView.frame.height / 20
        let horizontalInset = (collectionView.frame.width - ( 2 * cellWidth + itemSpacing)) / 2
        return UIEdgeInsets(top: verticalInset, left: horizontalInset, bottom:  verticalInset, right: horizontalInset)
    }
}

extension AllCharactersViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if let name = searchBar.text {
            viewModel.fetchCharacters(withName: name)
        }
    }
}

extension AllCharactersViewController: AllCharactersViewDelegate {
    
    func show(error: String) {
        print(error)
    }
    
    func show(characters: [CharacterViewModel]) {
        self.characters.append(contentsOf: characters)
    }
}
