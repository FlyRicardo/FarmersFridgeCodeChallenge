//
//  SteamWordViewModel.swift
//  FarmersFridgeCodeChallenge
//
//  Created by Fabian  Rodriguez on 6/04/24.
//

import Foundation

struct StemWordViewModel {
    // MARK: - Properties
    let stemWordData: StemWordData
    
    // MARK: - Public API
    var stemWord: String {
        stemWordData.stemWord
    }
    
    var occurrance: Int {
        stemWordData.occurrance
    }
    
    var inflectionalWords: [String] {
        stemWordData.inflectionalWords
    }
    
}

extension StemWordViewModel: StemWordPresentable {
    
}
