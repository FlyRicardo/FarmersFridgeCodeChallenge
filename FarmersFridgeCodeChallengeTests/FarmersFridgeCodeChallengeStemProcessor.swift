//
//  FarmersFridgeCodeChallengeStemProcessor.swift
//  FarmersFridgeCodeChallengeTests
//
//  Created by Fabian  Rodriguez on 6/04/24.
//

@testable import FarmersFridgeCodeChallenge
import XCTest

final class FarmersFridgeCodeChallengeStemProcessor: XCTestCase {
    
    let stemProcessor: Stemable = StemProcessor()

    override func setUp() {
        
    }
    
    override func tearDown() {
        
    }
    
    func testStem_NoRuleApplied_KeepsOriginalWord() {
        /// Given
        let word = "MZV"
        
        /// When
        let stemWord = stemProcessor.stem(word)
        
        /// Then
        XCTAssert(stemWord == word, "Should keep original word")
    }
    
    func testStem_WithSingleDoubleTripleLetterSuffixes_RuleAppliedDoesNotChangeWord() {
        ///Given
        let word1 = "L" /// suffix rule: L
        let word2 = "A"
        
        let word3 = "LZ" /// sufix rule: LZ
        let word4 = "ZQ" /// suffix rule: ZQ
        let word5 = "AB"
        
        let word6 = "EVM" /// suffix rule: EVM
        let word7 = "NZL" /// suffix rule: NZL
        let word8 = "PZL" /// suffix rule: PZL
        let word9 = "EZL" /// suffix rule: EZL
        let word10 = "ABC"

        /// When
        let stemWord1 = stemProcessor.stem(word1)
        let stemWord2 = stemProcessor.stem(word2)
        let stemWord3 = stemProcessor.stem(word3)
        let stemWord4 = stemProcessor.stem(word4)
        let stemWord5 = stemProcessor.stem(word5)
        let stemWord6 = stemProcessor.stem(word6)
        let stemWord7 = stemProcessor.stem(word7)
        let stemWord8 = stemProcessor.stem(word8)
        let stemWord9 = stemProcessor.stem(word9)
        let stemWord10 = stemProcessor.stem(word10)
        
        /// Then
        XCTAssertEqual(stemWord1, word1)
        XCTAssertEqual(stemWord2, word2)
        XCTAssertEqual(stemWord3, word3)
        XCTAssertEqual(stemWord4, word4)
        XCTAssertEqual(stemWord5, word5)
        XCTAssertEqual(stemWord6, word6)
        XCTAssertEqual(stemWord7, word7)
        XCTAssertEqual(stemWord8, word8)
        XCTAssertEqual(stemWord9, word9)
        XCTAssertEqual(stemWord10, word10)
    }
    
    func testStem_SingleLetterSufixRuleApplied_ShouldRemoveSingleLetterSuffix() {
        /// Given
        let word = "IHFUL" /// suffix rule: L
        
        /// When
        let stemWord = stemProcessor.stem(word)
        
        /// Then
        XCTAssert(stemWord == "IHFU", "Should remove suffix [L]")
    }
    
    func testStem_DoubleLetterSufixRuleApplied_ShouldRemoveDoulbeLetterSuffix() {
        /// Given
        let word1 = "KMZZQ" /// suffix rule: ZQ
        let word2 = "KMZLZ" /// suffix rule: LZ
        
        /// When
        let stemWord1 = stemProcessor.stem(word1)
        let stemWord2 = stemProcessor.stem(word2)
        
        /// Then
        XCTAssert(stemWord1 == "KMZ", "Should remove suffix [ZQ]")
        XCTAssert(stemWord2 == "KMZ", "Should remove suffix [LZ]")
    }

    func testStem_TripeLetterSufixRuleApplied_ShouldRemoveTripeLetterSuffixAndAddBackRuleSuffix() {
        /// Given
        let word1 = "UZCUZLZVKDKEPZL" /// suffix rule: PZL
        let word2 = "UZCUZLZVKDKENZL" /// suffix rule: NZL
        let word3 = "UZCUZLZVKDKEEZL" /// suffix rule: EZL
        
        /// When
        let stemWord1 = stemProcessor.stem(word1)
        let stemWord2 = stemProcessor.stem(word2)
        let stemWord3 = stemProcessor.stem(word3)
        
        /// Then
        XCTAssert(stemWord1 == "UZCUZLZVKDKEA", "Removed [PZL] original suffix and added back new suffix [A]")
        XCTAssertEqual(stemWord2, "UZCUZLZVKDKEAZ", "Removed [NZL] original suffix and added back new suffix [AZ]")
        XCTAssertEqual(stemWord3, "UZCUZLZVKDKER", "Removed [EZL] original suffix and added back new suffix [R]")
    }

}
