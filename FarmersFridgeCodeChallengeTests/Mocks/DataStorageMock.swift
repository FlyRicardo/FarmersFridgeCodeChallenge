//
//  DataStorageMock.swift
//  FarmersFridgeCodeChallengeTests
//
//  Created by Fabian  Rodriguez on 8/04/24.
//

import Foundation
@testable import FarmersFridgeCodeChallenge

class DataStorageMock: Storable {
    static var readCounter = 0
    static var writeCounter = 0
    static var updateCounter = 0
    static var deleteCounter = 0
    static var deleteAllCounter = 0
    
    private var storedSteamWords: [StemWordData]?
    
    
    func read() -> [StemWordData]? {
        DataStorageMock.readCounter = DataStorageMock.readCounter + 1
        
        return storedSteamWords
    }
    
    func write(_ data: [StemWordData]) {
        DataStorageMock.writeCounter = DataStorageMock.writeCounter + 1
        
        storedSteamWords = data
    }
    
    func update(_ data: StemWordData) {
        DataStorageMock.updateCounter = DataStorageMock.updateCounter + 1
    }
    
    func delete(_ data: StemWordData) {
        DataStorageMock.deleteCounter = DataStorageMock.deleteCounter + 1
        
        storedSteamWords = nil
    }
    
    func deleteAll() {
        DataStorageMock.deleteAllCounter = DataStorageMock.deleteAllCounter + 1
        
        storedSteamWords = nil
    }
    
}

extension DataStorageMock {
    static func resetMockCounters() {
        DataStorageMock.readCounter = 0
        DataStorageMock.writeCounter = 0
        DataStorageMock.updateCounter = 0
        DataStorageMock.deleteCounter = 0
        DataStorageMock.deleteAllCounter = 0
    }
}
