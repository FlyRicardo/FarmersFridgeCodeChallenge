//
//  StemProcessor.swift
//  FarmersFridgeCodeChallenge
//
//  Created by Fabian  Rodriguez on 5/04/24.
//

import Foundation

struct StemProcessor: Stemable {
    func stem(_ word: String) -> String {
        
        var stemWord = word
        
        /// Removing suffix and adding back letters rules
        let suffix = stemWord.suffix(3)
        switch suffix {
        case "PZL":
            if word.count >= 4 {
                stemWord = String(word.dropLast(3))
                stemWord.append("A")
            }
            return stemWord
        case "NZL":
            if word.count >= 4 {
                stemWord = String(word.dropLast(3))
                stemWord.append("AZ")
            }
            return stemWord
        case "EZL":
            if word.count >= 4 {
                stemWord = String(word.dropLast(3))
                stemWord.append("R")
            }
            return stemWord
            
        default:
            break
            
        }
        
        /// Removing suffix rules
        switch word.last {
        case Character("L"):
            if word.count >= 2 {
                stemWord = String(word.dropLast())
            }
            return stemWord
            
        case Character("Z"):
            if word.count >= 3 {
                let beforeLastIndex = word.index(word.endIndex, offsetBy: -2)
                
                if word[beforeLastIndex] == Character("L") {
                    stemWord = String(word.dropLast(2))
                }
            }
            return stemWord
            
        case Character("Q"):
            if word.count >= 3 {
                let beforeLastIndex = word.index(word.endIndex, offsetBy: -2)
                
                if word[beforeLastIndex] == Character("Z") {
                    stemWord = String(word.dropLast(2))
                }
            }
            return stemWord
            
        case Character("M"):
            if word.count >= 4 {
                let beforeLastIndex = word.index(word.endIndex, offsetBy: -2)
                let beforeBeforeLastIndex = word.index(word.endIndex, offsetBy: -3)
                
                if word[beforeLastIndex] == Character("V") && 
                   word[beforeBeforeLastIndex] == Character("E") {
                    stemWord = String(word.dropLast(3))
                }
            }
            return stemWord
            
        default:
            break
            
        }
        
        return stemWord
    }
}
