//
//  SeoulSubwayArrivalDataProvider.swift
//  NextTrain
//
//  Created by Joey on 3/11/21.
//

import Foundation

class SeoulSubwayArrivalDataProvider: ArrivalDataProvider {

    private static let baseUrl = "http://swopenapi.seoul.go.kr/api/subway/\(Environment.subwayApiKey)/json/realtimeStationArrival/0/20/"

    func fetchArrivalInfo(for stationName: String) async throws -> [ArrivalInfo] {
        let urlString = SeoulSubwayArrivalDataProvider.baseUrl + stationName

        guard
            let escapedUrl = urlString.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed),
            let url = URL(string: escapedUrl)
        else {
            throw ArrivalDataProviderError.invalidURL
        }

        let (data, _) = try await URLSession.shared.data(from: url)
        let response = try JSONDecoder().decode(ArrivalInfoResponse.self, from: data)

        //printResponse(res, data)

        guard let arrivalInfo = response.realtimeArrivalList, !arrivalInfo.isEmpty else {
            let errorMessage = response.message ?? response.errorMessage?.message ?? ""
            throw ArrivalDataProviderError.missingData(message: errorMessage)
        }

        return arrivalInfo
    }

    private func printResponse(_ response: URLResponse?, _ data: Data?) {
        if let httpResponse = response as? HTTPURLResponse, let url = httpResponse.url {
            print("")
            print("Request \(String(describing: url)):")
            print("Response headers:")
            httpResponse.allHeaderFields.forEach { print("\($0.key):  \($0.value)") }
            print("Status code:", httpResponse.statusCode)
            print("Response body:")
            if let data = data, let utf8Text = String(data: data, encoding: .utf8), utf8Text.count < 90000 {
                print(utf8Text)
            } else {
                print("Body too large to print :(")
            }
            print("")
        }
    }

}
