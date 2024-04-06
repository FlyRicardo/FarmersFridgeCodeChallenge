//
//  DataRepository.swift
//  FarmersFridgeCodeChallenge
//
//  Created by Fabian  Rodriguez on 5/04/24.
//

import Foundation

protocol Storable {
    func read() -> [StemWordData]?
    func write(_ data: [StemWordData])
    func update(_ data: StemWordData)
    func delete(_ data: StemWordData)
    func deleteAll()
}
