//
//  RepositoriesError.swift
//  FarmersFridgeCodeChallenge
//
//  Created by Fabian  Rodriguez on 5/04/24.
//

import Foundation

enum RepositoriesError: Error {
    case errorDecodingJson(Error)
    case errorEncodingJson(Error)
    case documentsDirectoryFound
    case errorWritingJson(Error)
    case fileNotFound
    case errorLoadingJson
    
    var localizedDescription: String {
        switch self {
        case .errorDecodingJson(let error):
            return "Error decoding Json data: \(error.localizedDescription)"
        case .errorEncodingJson(let error):
            return "Error encoding data to Json: \(error.localizedDescription) "
        case .documentsDirectoryFound:
            return "Documents directory not found"
        case .errorWritingJson(let error):
            return "Error writing Json data: \(error.localizedDescription)"
        case .fileNotFound:
            return "Failed to locate StemWords.json in bundle"
        case .errorLoadingJson:
            return"Failed to load users.json from bundle"
        }
    }
}
