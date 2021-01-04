//
//  ViewCoding.swift
//  ChuckNorrisFacts
//
//  Created by Paulo Ricardo on 21/12/20.
//

import Foundation

protocol ViewCodable {
    func setupViewHierarchy()
    func setupConstraints()
}

extension ViewCodable {
    func setupView() {
        setupViewHierarchy()
        setupConstraints()
    }
}
