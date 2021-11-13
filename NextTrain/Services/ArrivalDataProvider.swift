//
//  ArrivalDataProvider.swift
//  NextTrain
//
//  Created by Joey on 3/11/21.
//

import Foundation

enum ArrivalDataProviderError: Error {
    case invalidURL
    case missingData(message: String)
}

protocol ArrivalDataProvider {

    func fetchArrivalInfo(for stationName: String) async throws -> [ArrivalInfo]

}
