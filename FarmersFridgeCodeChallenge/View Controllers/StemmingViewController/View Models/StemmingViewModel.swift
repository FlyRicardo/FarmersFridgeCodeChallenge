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
        
//        if let storedStemWords = dataStorage.read() {
//            
//            /// Update storedSteamWords
//            var storedSteamWordsUpdated = storedStemWords.map { (storedStemWord: StemWordData) in
//                if let stemWordToUpdate = inputsStemWords.first(where: { storedStemWord.id == $0.id })  { /// If element needs to be updated
//                    /// update storeSteamWord with inputStoredWord
//                    return StemWordData(
//                        stemWord: storedStemWord.stemWord,
//                        occurrance: storedStemWord.occurrance + stemWordToUpdate.occurrance,
//                        inflectionalWords: storedStemWord.inflectionalWords +  stemWordToUpdate.inflectionalWords
//                    )
//                }
//                
//                return storedStemWord  /// Stored stem word didn't need to be updated
//            }
//            
//            /// New storedSteamWord
//            let newStemWords = inputsStemWords.filter { stem in !storedStemWords.contains(where: { stem.id == $0.id }) }
//            storedSteamWordsUpdated.append(contentsOf: newStemWords)
//            
//            dataStorage.write(storedSteamWordsUpdated)
//        }
        
        let updatedInputStemWords = dataStorage.read()?.filter { storedStemWord in
            inputStemWords.contains(where: {$0.id == storedStemWord.id})
        }
        
        updatedInputStemWords.flatMap{self.stemWordsData = $0}
    
    }
}
