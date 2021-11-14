//
//  SeoulSubwayInfoDataProvider.swift.swift
//  NextTrain
//
//  Created by Joey on 3/11/21.
//

import Foundation
import UIKit

class SeoulSubwayInfoDataProvider: SubwayInfoDataProvider {

    private static let lineNameMap: [String: String] = [
        "1001": "1",
        "1002": "2",
        "1003": "3",
        "1004": "4",
        "1005": "5",
        "1006": "6",
        "1007": "7",
        "1008": "8",
        "1009": "9",
        "1063": "경의중앙선",
        "1065": "공항철도",
        "1067": "경춘선",
        "1069": "인천1",
        "1071": "수인선",
        "1075": "분당선",
        "1077": "신분당선"
    ]

    private static let lineColorMap: [String: UIColor] = [
        "1001": UIColor(red: 0.15, green: 0.24, blue: 0.59, alpha: 1.00),
        "1002": UIColor(red: 0.23, green: 0.71, blue: 0.29, alpha: 1.00),
        "1003": UIColor(red: 0.97, green: 0.46, blue: 0.21, alpha: 1.00),
        "1004": UIColor(red: 0.17, green: 0.62, blue: 0.87, alpha: 1.00),
        "1005": UIColor(red: 0.51, green: 0.24, blue: 0.86, alpha: 1.00),
        "1006": UIColor(red: 0.71, green: 0.31, blue: 0.05, alpha: 1.00),
        "1007": UIColor(red: 0.41, green: 0.45, blue: 0.08, alpha: 1.00),
        "1008": UIColor(red: 0.89, green: 0.12, blue: 0.43, alpha: 1.00),
        "1009": UIColor(red: 0.79, green: 0.65, blue: 0.33, alpha: 1.00),
        "1063": UIColor(red: 0.49, green: 0.77, blue: 0.66, alpha: 1.00),
        "1065": UIColor(red: 0.45, green: 0.71, blue: 0.89, alpha: 1.00),
        "1067": UIColor(red: 0.31, green: 0.76, blue: 0.62, alpha: 1.00),
        "1069": UIColor(red: 0.44, green: 0.60, blue: 0.82, alpha: 1.00),
        "1071": UIColor(red: 0.90, green: 0.00, blue: 0.40, alpha: 1.00),
        "1075": UIColor(red: 0.90, green: 0.80, blue: 0.00, alpha: 1.00),
        "1077": UIColor(red: 0.95, green: 0.85, blue: 0.12, alpha: 1.00),
    ]

    func fetchStation(from query: String) -> SubwayStation {
        return SubwayStation(id: "0", name: "Test")
    }

    func lineName(from id: String?) -> String {
        guard let id = id else { return "Unknown line" }
        return SeoulSubwayInfoDataProvider.lineNameMap[id] ?? "Unknown line"
    }

    func lineColor(from id: String?) -> UIColor {
        guard let id = id else { return .darkGray }
        return SeoulSubwayInfoDataProvider.lineColorMap[id] ?? .darkGray
    }

}
