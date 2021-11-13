//
//  CsvReader.swift
//  NextTrain
//
//  Created by Joey on 8/11/21.
//

import Foundation

enum CsvReaderError: Error {
    case fileNotFound
    case invalidData
}

protocol CsvReader {
    associatedtype T
    func readFile(fileName: String) throws -> T
}

extension CsvReader {

    func fileDataAsString(fileName: String, from bundle: Bundle = Bundle.main) throws -> String {
        guard let filepath = bundle.path(forResource: fileName, ofType: "csv") else {
            throw CsvReaderError.fileNotFound
        }
        let contents = try String(contentsOfFile: filepath, encoding: .utf8)
        return contents
    }

}
