//
//  StemWordPresentable.swift
//  FarmersFridgeCodeChallenge
//
//  Created by Fabian  Rodriguez on 6/04/24.
//

import Foundation

protocol StemWordPresentable {
    // MARK: - Properties
    
    var stemWord: String { get }
    var occurrance: Int { get }
    var inflectionalWords: [String] { get }
}
