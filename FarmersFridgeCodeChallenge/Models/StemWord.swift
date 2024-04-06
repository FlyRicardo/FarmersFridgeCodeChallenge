//
//  StemWord.swift
//  FarmersFridgeCodeChallenge
//
//  Created by Fabian  Rodriguez on 4/04/24.
//

import Foundation

struct StemWord : Codable {
    let stemWord: String
    let occurrance: Int
    let inflectionalWords: [String]
}

// MARK: - Equatable
extension StemWord: Equatable {
    static func ==(rhs: StemWord, lhs: StemWord) -> Bool {
        return lhs.stemWord == rhs.stemWord
    }
}
