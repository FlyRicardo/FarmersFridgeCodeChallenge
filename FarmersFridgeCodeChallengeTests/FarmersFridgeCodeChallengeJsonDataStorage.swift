//
//  FarmersFridgeCodeChallengeJsonDataStorage.swift
//  FarmersFridgeCodeChallengeUITests
//
//  Created by Fabian  Rodriguez on 5/04/24.
//

import XCTest
@testable import FarmersFridgeCodeChallenge

final class FarmersFridgeCodeChallengeJsonDataStorage: XCTestCase {
    
    var jsonDataStorage = JsonDataStorage<StemWord>(
        fileName: "StemWordsTest",
        extensionType: "json"
    )
    
    override func setUp() {
        let stemWordTest = StemWord(
            stemWord: "stemWordTest",
            occurrance: 3,
            inflectionalWords:["inflectionalWordTest"]
        )
        
        jsonDataStorage.write([stemWordTest])
    }
    
    override func tearDown() {
        jsonDataStorage.deleteAll()
    }
    
    func testJsonDataStorage_WhenWritingTestStemWord_ShouldCreateAReadableJsonFile() {
        /// Given
        let stemWordTest = StemWord(
            stemWord: "stemWordTest1",
            occurrance: 5,
            inflectionalWords:["inflectionalWordTest1", "inflectionalWordTest2"]
        )
        
        /// When
        jsonDataStorage.write([stemWordTest])
        
        /// Then
        guard let storedStemWords = jsonDataStorage.read() else {
            XCTFail("Json file must not be empty")
            return
        }

        let storedStemWordTest = storedStemWords.filter { $0.stemWord == "stemWordTest1" }.first
        
        XCTAssertEqual(storedStemWordTest?.stemWord, stemWordTest.stemWord)
        XCTAssertEqual(storedStemWordTest?.inflectionalWords.count, stemWordTest.inflectionalWords.count)
        
    }
    
    func testJsonDataStorage_WhenReading_JsonFileMustNotBeNil() {
        /// When
        guard let storedStemWords = jsonDataStorage.read() else {
            XCTFail("Json file must not be empty")
            return
        }
        
        let storedStemWordTest = storedStemWords.filter { $0.stemWord == "stemWordTest" }.first
        
        /// Then
        XCTAssert(storedStemWords.count == 1, "The only one saved in the setUp()")
        XCTAssertNotNil(storedStemWordTest)
        XCTAssertEqual(storedStemWordTest?.inflectionalWords.count, 1)
        XCTAssertEqual(storedStemWordTest?.occurrance, 3)
    }
    
    func testJsonDataStorage_WhenUpdatingElement_JsonFileMustSaveUpdatedElement() {
        /// When
        let stemWordTestUpdated = StemWord(
            stemWord: "stemWordTest",
            occurrance: 1000,
            inflectionalWords:[String]()
        )

        jsonDataStorage.write([stemWordTestUpdated])
        
        /// Then
        guard let storedStemWords = jsonDataStorage.read() else {
            XCTFail("Json file must not be empty")
            return
        }
        
        XCTAssert(storedStemWords.count == 1, "The only one saved in the setUp()")
        XCTAssert(storedStemWords.first?.stemWord == stemWordTestUpdated.stemWord)
        XCTAssert(storedStemWords.first?.occurrance == stemWordTestUpdated.occurrance)
        XCTAssert(storedStemWords.first?.inflectionalWords.count == stemWordTestUpdated.inflectionalWords.count)

    }
    
    func testJsonDataStorage_WhenDeleteSingleElement_JsonFileMustBeEmpty() {
        /// Given
        let stemWordToBeDeleted = StemWord(
            stemWord: "stemWordTest",
            occurrance: 0,
            inflectionalWords: [String]()
        )
        
        /// When
        jsonDataStorage.delete(stemWordToBeDeleted)
        
        /// Then
        guard let storedStemWords = jsonDataStorage.read() else {
            XCTFail("Json file must not be empty")
            return
        }
    
        XCTAssert(storedStemWords.isEmpty, "After delete the only element in file, this must be empty")
    }

}
