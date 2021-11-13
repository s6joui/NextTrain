//
//  StationDataCsvReader.swift
//  NextTrain
//
//  Created by Joey on 8/11/21.
//

import Foundation

class StationDataCsvReader: CsvReader {

    typealias T = [SubwayStation]

    func readFile(fileName: String) throws -> [SubwayStation] {
        let stringData = try fileDataAsString(fileName: fileName)

        let lines: [String] = stringData.components(separatedBy: NSCharacterSet.newlines) as [String]
        let stations: [SubwayStation] = lines.compactMap {
            let comps = $0.components(separatedBy: ";") as [String]
            if comps.count > 2 {
                let stationId = comps[1]
                let stationName = comps[2]
                return SubwayStation(id: stationId, name: stationName)
            }
            return nil
        }

        return stations
    }

}
