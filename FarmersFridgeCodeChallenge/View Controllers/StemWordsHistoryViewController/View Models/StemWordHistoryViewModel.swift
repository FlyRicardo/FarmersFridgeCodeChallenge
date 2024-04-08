//
//  StemWordHistoryViewModel.swift
//  FarmersFridgeCodeChallenge
//
//  Created by Fabian  Rodriguez on 6/04/24.
//

import Foundation

class StemWordHistoryViewModel {
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
    
    func cellViewModel(for index: Int) -> StemWordCellViewModel? {
        guard
            let sStemWordsData = stemWordsData,
            !sStemWordsData.isEmpty
        else {
            return nil
        }

        return StemWordCellViewModel(stemWordData: sStemWordsData[index])
    }
    
    func loadStemWordHistory() {
        dataStorage.read().flatMap { self.stemWordsData = $0 }
    }
    
    func clearHistory() {
        dataStorage.deleteAll()
        
        dataStorage.read().flatMap { self.stemWordsData = $0 }
    }
}
