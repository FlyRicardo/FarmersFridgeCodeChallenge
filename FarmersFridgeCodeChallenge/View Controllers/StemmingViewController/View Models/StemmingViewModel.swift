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
    private let stemProcessor: Stemable
    var onListDidChange: (() -> Void)? = nil
    
    // MARK: - Properties
    var stemWordsData: [StemWordData]? {
        didSet {
            onListDidChange?()
        }
    }
    
    init(
        dataStorage: Storable = JsonDataStorage(),
        stemWordsData: StemWordData? = nil,
        stemProcessor: Stemable = StemProcessor()
    ) {
        self.dataStorage = dataStorage
        self.stemWordsData = [StemWordData]()
        self.stemProcessor = stemProcessor
    }
    
    func cellViewModel(for index: Int) -> StemWordCellViewModel? {
        guard
            let sStemWordsData = stemWordsData,
            !sStemWordsData.isEmpty
        else {
            return nil
        }

        return StemWordCellViewModel(stemWordData: sStemWordsData[index])
    }
    
    func stem(_ string: String) {
        if string.isEmpty { return }
        
        let words = string.split(separator: " ").map { String($0) }
        
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
    
    func clearStemWords() {
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
