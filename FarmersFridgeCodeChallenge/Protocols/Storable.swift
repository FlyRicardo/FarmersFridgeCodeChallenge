//
//  DataRepository.swift
//  FarmersFridgeCodeChallenge
//
//  Created by Fabian  Rodriguez on 5/04/24.
//

import Foundation

protocol Storable {
    associatedtype T: Codable & Equatable
    
    func read() -> [T]?
    func write(_ data: [T])
    func delete(_ data: T)
    func deleteAll()
}
