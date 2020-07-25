//
//  ViewCode.swift
//  iOSproject
//
//  Created by Gabriel Faria on 7/25/20.
//  Copyright © 2020 Gabriel Rodrigues. All rights reserved.
//

import Foundation

protocol ViewCode {
    func setupView()
    func createSubviews()
    func createConstraints()
    func additionalSetup()
}

extension ViewCode {
    func setupView() {
        createSubviews()
        createConstraints()
        additionalSetup()
    }
    
    func additionalSetup(){}
}
