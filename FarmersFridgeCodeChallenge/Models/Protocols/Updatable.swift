//
//  Updatable.swift
//  FarmersFridgeCodeChallenge
//
//  Created by Fabian  Rodriguez on 6/04/24.
//

import Foundation

protocol Updatable {
    associatedtype T
    mutating func update<T>(with value: T)
}
