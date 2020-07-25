//
//  CharacterIconCell.swift
//  iOSproject
//
//  Created by Gabriel Faria on 7/25/20.
//  Copyright © 2020 Gabriel Rodrigues. All rights reserved.
//

import Foundation
import UIKit

class CharacterIconCell: UICollectionViewCell {
    
    var imageView: UIImageView!
    var nameLabel: UILabel!
    
    override init(frame: CGRect = .zero) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented - CharacterIconCell")
    }
}

extension CharacterIconCell: ViewCode {
    
    func createSubviews() {
        imageView = UIImageView()
        addSubview(imageView)
        
        nameLabel = UILabel()
        addSubview(nameLabel)
    }
    
    func createConstraints() {
        NSLayoutConstraint.activate([
            nameLabel.bottomAnchor.constraint(equalTo: bottomAnchor),
            nameLabel.leadingAnchor.constraint(equalTo: leadingAnchor),
            nameLabel.trailingAnchor.constraint(equalTo: trailingAnchor),
            nameLabel.heightAnchor.constraint(equalToConstant: 28)
        ])
        
        NSLayoutConstraint.activate([
            imageView.topAnchor.constraint(equalTo: topAnchor),
            imageView.leadingAnchor.constraint(equalTo: leadingAnchor),
            imageView.trailingAnchor.constraint(equalTo: trailingAnchor),
            imageView.bottomAnchor.constraint(equalTo: nameLabel.topAnchor)
        ])
    }
}
