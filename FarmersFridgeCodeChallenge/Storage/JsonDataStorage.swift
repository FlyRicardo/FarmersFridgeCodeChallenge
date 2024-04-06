//
//  JsonRepository.swift
//  FarmersFridgeCodeChallenge
//
//  Created by Fabian  Rodriguez on 5/04/24.
//

import Foundation
/**
     Struct responsible for reading and writting locally steam-words in JSON format
 */
struct JsonDataStorage<T: Codable & Equatable>: Storable {
    
    let fileName: String
    let extensionType: String
    
    init(
        fileName: String = "StemWords",
        extensionType: String = "json"
    ) {
        self.fileName = fileName
        self.extensionType = extensionType
    }
    
     func read() -> [T]? {
        return load()
    }
    
     func write(_ data: [T]) {
        guard var storedData = read() else {
            save(data)
            return
        }
        
        data.forEach { item in
            if let index = storedData.firstIndex(where:{ $0 == item }) {
                storedData[index] = item
            }
            else {
                storedData.append(item)
            }
        }
        
        save(storedData)
    }
    
     func delete(_ data: T) {
        if var storedData = read() {
            if let index = storedData.firstIndex(where:{ $0 == data }) {
                storedData.remove(at: index)
                save(storedData)
            }
        }
    }
    
     func deleteAll() {
        if var storedModel = read(), !storedModel.isEmpty {
            storedModel.removeAll()
            save(storedModel)
        }
    }
}

// MARK: - Private utility methods

private extension JsonDataStorage {
     func save(_ data: [T]) {
        guard let jsonData = encodeToJson(data) else {
            return
        }

        guard let documentsDirectory = FileManager.default.urls(
            for: .documentDirectory,
            in: .userDomainMask
        ).first
        else {
            fatalError(RepositoriesError.documentsDirectoryFound.localizedDescription)
        }
        
        let fileURL = documentsDirectory.appendingPathComponent("\(fileName).\(extensionType)")
        
        do {
            try jsonData.write(to: fileURL, options: .atomic)
        } catch {
            print(RepositoriesError.errorWritingJson(error).localizedDescription)
        }
    }
    
     func load() -> [T]? {
        
        let fileManager = FileManager.default
        do {
            let documentDirectory = try fileManager.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: false)
            
            let fileURL = documentDirectory.appendingPathComponent("\(fileName).\(extensionType)")
            
            guard let data = try? Data(contentsOf: fileURL) else {
                print(RepositoriesError.errorLoadingJson.localizedDescription)
                return nil
            }

            let decodedJson = decodeJson(data: data)
            return decodedJson

        } catch {
            print(RepositoriesError.fileNotFound.localizedDescription)
            return nil
        }
        
        
    }
    
     func encodeToJson(_ data: [T]) -> Data? {
        do {
            let encoder = JSONEncoder()
            let jsonData = try encoder.encode(data)
            return jsonData
        } catch {
            print(RepositoriesError.errorEncodingJson(error).localizedDescription)
            return nil
        }
    }
    
     func decodeJson(data: Data) -> [T]? {
        do {
            let decoder = JSONDecoder()
            let decodedData = try decoder.decode([T].self, from: data)
            return decodedData
        } catch {
            print(RepositoriesError.errorDecodingJson(error).localizedDescription)
            return nil
        }
    }
}
