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
    
    // MARK: - Properties
    
    var stemWordsData: [StemWordData]
    
    // MARK: - Public API
    var numberOfSections: Int {
        1
    }

    var numberOfSteamWords: Int {
        stemWordsData.count
    }
    
    init(dataStorage: Storable = JsonDataStorage()) {
        self.dataStorage = dataStorage
        self.stemWordsData = [StemWordData]()
    }
    
    func viewModel(for index: Int) -> StemWordViewModel {
        StemWordViewModel(stemWordData: stemWordsData[index])
    }
    
    func stem(_ words: [String]) {
        let stemProcessor: Stemable = StemProcessor()
        
        let inputsStemWords = words.map {
            StemWordData(
                stemWord: stemProcessor.stem($0),
                occurrance: 1,
                inflectionalWords: [$0]
            )
        }
        
        if let storedStemWords = dataStorage.read() {
            
            /// Update storedSteamWords
            var storedSteamWordsUpdated = storedStemWords.map { (storedStemWord: StemWordData) in
                if let stemWordToUpdate = inputsStemWords.first(where: { storedStemWord.id == $0.id })  { /// If element needs to be updated
                    /// update storeSteamWord with inputStoredWord
                    return StemWordData(
                        stemWord: storedStemWord.stemWord,
                        occurrance: storedStemWord.occurrance + stemWordToUpdate.occurrance,
                        inflectionalWords: storedStemWord.inflectionalWords +  stemWordToUpdate.inflectionalWords
                    )
                }
                
                return storedStemWord  /// Stored stem word didn't need to be updated
            }
            
            /// New storedSteamWord
            let newStemWords = inputsStemWords.filter { stem in !storedStemWords.contains(where: { stem.id == $0.id }) }
            storedSteamWordsUpdated.append(contentsOf: newStemWords)
            
            dataStorage.write(storedSteamWordsUpdated)
        }

        dataStorage.read().flatMap { self.stemWordsData = $0 }
    }
}
