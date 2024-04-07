//
//  StemmingViewModel.swift
//  FarmersFridgeCodeChallenge
//
//  Created by Fabian  Rodriguez on 6/04/24.
//

import Foundation

final class StemmingViewModel {
    // MARK: - Dependencies
    private let dataStorage: Storable
    var onListDidChange: (() -> Void)? = nil
    
    // MARK: - Properties
    var stemWordsData: [StemWordData]? {
        didSet {
            onListDidChange?()
        }
    }
    
    init(
        dataStorage: Storable = JsonDataStorage(),
        stemWordsData: StemWordData? = nil
    ) {
        self.dataStorage = dataStorage
        self.stemWordsData = [StemWordData]()
    }
    
    func viewModel(for index: Int) -> StemWordViewModel? {
        guard
            let sStemWordsData = stemWordsData
        else {
            return nil
        }

        return StemWordViewModel(stemWordData: sStemWordsData[index])
    }
    
    func stem(_ string: String) {
        let words = string.split(separator: " ").map { String($0) }
        let stemProcessor: Stemable = StemProcessor()
        
        let inputStemWords = words.map {
            StemWordData(
                stemWord: stemProcessor.stem($0),
                occurrance: 1,
                inflectionalWords: [$0]
            )
        }
        
        dataStorage.write(inputStemWords)
        refreshInputSteamWords(inputStemWords)
    }
    
    func clearHistory() {
        stemWordsData = nil
    }
}

private extension StemmingViewModel {
    func refreshInputSteamWords(_ inputStemWords: [StemWordData]) {
        /// read input stem words with posibles updates
        let updatedInputStemWords = dataStorage.read()?.filter { storedStemWord in
            inputStemWords.contains(where: {$0.id == storedStemWord.id})
        }
        
        updatedInputStemWords.flatMap{self.stemWordsData = $0}
    }
}
