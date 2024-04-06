//
//  StemWord.swift
//  FarmersFridgeCodeChallenge
//
//  Created by Fabian  Rodriguez on 4/04/24.
//

import Foundation

struct StemWordData : Codable {
    let stemWord: String
    var occurrance: Int
    var inflectionalWords: [String]
}

// MARK: - Identifiable
extension StemWordData: Identifiable {
    var id: String {
        stemWord
    }
}
