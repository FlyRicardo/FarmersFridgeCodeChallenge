//
//  FarmersFridgeCodeChallengeStemmingViewModelTest.swift
//  FarmersFridgeCodeChallengeTests
//
//  Created by Fabian  Rodriguez on 8/04/24.
//

import XCTest
@testable import FarmersFridgeCodeChallenge

final class StemmingViewModelTest: XCTestCase {

    override func setUp() {
        DataStorageMock.resetMockCounters()
    }
    
    override func tearDown() {
        
    }
    
    func testStem_WhenStringIsNotEmpty_ShouldPersistStemWordsAndExecuteBoundClosure() {
        /// Given
        let dataStorage: Storable = DataStorageMock()
        let viewModel: StemmingViewModel = StemmingViewModel(dataStorage: dataStorage)
        
        
        viewModel.onListDidChange = {
            /// Then
            XCTAssert(viewModel.stemWordsData?.count != 0)
        }
        
        /// When
        viewModel.stem("Words to be stem input")
        
        /// Then
        XCTAssert(DataStorageMock.writeCounter == 1)
        XCTAssert(DataStorageMock.readCounter == 1)
    }
    
    func testStem_WhenStringIsEmpty_ShoudNotWriteOrReadNietherCallBoundClosure() {
        /// Given
        let dataStorage: Storable = DataStorageMock()
        let viewModel: StemmingViewModel = StemmingViewModel(dataStorage: dataStorage)
        
        viewModel.onListDidChange = {
            XCTFail()
        }
        
        /// When
        viewModel.stem("")
        
        /// Then
        XCTAssert(DataStorageMock.writeCounter == 0)
        XCTAssert(DataStorageMock.readCounter == 0)
    }
    
    func testClearStemWords_ShouldRemoveAllStemWords() {
        /// Given
        let dataStorage: Storable = DataStorageMock()
        let viewModel: StemmingViewModel = StemmingViewModel(dataStorage: dataStorage)
        
        
        viewModel.onListDidChange = {
            /// Then
            XCTAssertNil(viewModel.stemWordsData)
        }
        
        /// When
        viewModel.clearStemWords()
    }
    
    func testViewCellModel_WhenThereAreStemWordsToBeDisplayed_ShouldReturnViewCellModel() {
        /// Given
        let dataStorage: Storable = DataStorageMock()
        let viewModel: StemmingViewModel = StemmingViewModel(dataStorage: dataStorage)
        
        /// When
        viewModel.stem("TestWord")
        
        let indexPathRow = 0
        let viewCellModel = viewModel.cellViewModel(for: indexPathRow)
        
        /// Then
        XCTAssertNotNil(viewCellModel)
        XCTAssertEqual(viewCellModel?.stemWord, "TestWord")
    }
    
    func testViewCellModel_WhenThereAreNotStemWordsToBeDisplayed_ShouldReturnNil() {
        /// Given
        let dataStorage: Storable = DataStorageMock()
        let viewModel: StemmingViewModel = StemmingViewModel(dataStorage: dataStorage)
        
        /// When
        viewModel.stem("")
        
        let indexPathRow = 0
        let viewCellModel = viewModel.cellViewModel(for: indexPathRow)
        
        /// Then
        XCTAssertNil(viewCellModel)
    }
}
