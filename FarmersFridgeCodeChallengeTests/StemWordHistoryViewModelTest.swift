//
//  StemWordHistoryViewModelTest.swift
//  FarmersFridgeCodeChallengeTests
//
//  Created by Fabian  Rodriguez on 8/04/24.
//

import XCTest
@testable import FarmersFridgeCodeChallenge

final class StemWordHistoryViewModelTest: XCTestCase {

    override func setUp() {
        DataStorageMock.resetMockCounters()
    }
    
    override func tearDown() {
        
    }
    
    func testLoadstemWordHistory_WhenThereAreStoredStemWords_ShouldExecuteBoundClosure() {
        /// Given
        let dataStorage: Storable = DataStorageMock()
        let viewModel: StemWordHistoryViewModel = StemWordHistoryViewModel(dataStorage: dataStorage)
        
        let expectation = XCTestExpectation(description: "Bound closure should be executed")
        
        
        viewModel.onListDidChange = {
            /// Then
            XCTAssert(viewModel.stemWordsData?.count != 0)
            expectation.fulfill()
        }
        
        /// When
        dataStorage.write([
            StemWordData(
                stemWord: "TestWord",
                occurrance: 0,
                inflectionalWords: [String]()
            )
        ])
        viewModel.loadStemWordHistory()
        
        /// Then
        XCTAssert(DataStorageMock.readCounter == 1)
        wait(for:[expectation], timeout: 1)
        
    }
    
    func testLoadstemWordHistory_WhenThereAreNotStoredStemWords_ShouldExecuteBoundClosure() {
        /// Given
        let dataStorage: Storable = DataStorageMock()
        let viewModel: StemWordHistoryViewModel = StemWordHistoryViewModel(dataStorage: dataStorage)
        
        let expectation = XCTestExpectation(description: "Bound closure should be executed")
        
        
        viewModel.onListDidChange = {
            /// Then
            XCTAssert(viewModel.stemWordsData?.isEmpty == true)
            expectation.fulfill()
        }
        
        /// When
        dataStorage.write([StemWordData]())
        viewModel.loadStemWordHistory()
        
        /// Then
        XCTAssert(DataStorageMock.readCounter == 1)
        wait(for:[expectation], timeout: 1)
    }
    
    func testViewCellModel_WhenThereAreStemWordsToBeDisplayed_ShouldReturnViewCellModel() {
        /// Given
        let dataStorage: Storable = DataStorageMock()
        let viewModel: StemWordHistoryViewModel = StemWordHistoryViewModel(dataStorage: dataStorage)
        
        /// When
        dataStorage.write([
            StemWordData(
                stemWord: "TestWord",
                occurrance: 0,
                inflectionalWords: [String]()
            )
        ])
        viewModel.loadStemWordHistory()
        
        let indexPathRow = 0
        let viewCellModel = viewModel.cellViewModel(for: indexPathRow)
        
        /// Then
        XCTAssertNotNil(viewCellModel)
        XCTAssertEqual(viewCellModel?.stemWord, "TestWord")
    }
    
    func testViewCellModel_WhenThereAreNotStemWordsToBeDisplayed_ShouldReturnNil() {
        /// Given
        let dataStorage: Storable = DataStorageMock()
        let viewModel: StemWordHistoryViewModel = StemWordHistoryViewModel(dataStorage: dataStorage)
        
        /// When
        viewModel.loadStemWordHistory()
        
        let indexPathRow = 0
        let viewCellModel = viewModel.cellViewModel(for: indexPathRow)
        
        /// Then
        XCTAssertNil(viewCellModel)
    }
    
    func testClearHistory_ShouldRemoveStoredStemWords() {
        /// Given
        let dataStorage: Storable = DataStorageMock()
        let viewModel: StemWordHistoryViewModel = StemWordHistoryViewModel(dataStorage: dataStorage)

        
        viewModel.clearHistory()

        XCTAssertEqual(DataStorageMock.deleteAllCounter, 1)
    }

}
