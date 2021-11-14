//
//  ArrivalCardViewModel.swift
//  NextTrain
//
//  Created by Joey on 3/11/21.
//

import Foundation
import UIKit

struct ArrivalCardViewModel {

    let lineName: String
    let trainNumber: String
    let status: String
    let currentLocation: String
    let baseStation: String
    let direction: String
    let heading: SubwayHeading
    let lineColor: UIColor
    let arrivalStationName: String

    private var minutesRemaining: Double? {
        if let minuteChar = status.firstIndex(of: "분") {
            let minutes = status.prefix(upTo: minuteChar)
            return Double(minutes)
        } else if let secondChar = status.firstIndex(of: "초") {
            let seconds = status.prefix(upTo: secondChar)
            return Double(seconds) != nil ? Double(seconds)! / 60 : nil
        } else if status == "전역 진입" {
            return 3
        } else if status == "전역 도착" {
            return 2
        } else if status == "전역 출발" {
            return 1
        } else if status.contains("도착") {
            return 0
        }
        return nil
    }

    private var stationsRemaining: Int? {
        if status.contains("번째") {
            // Get int in string
            let comps = status.components(separatedBy: CharacterSet.decimalDigits.inverted)
            let stations = comps.first(where: { Int($0) != nil }) ?? ""
            return Int(stations)
        }
        return nil
    }

    var message: String {
        if status.contains("전역 도착") {
            return NSLocalizedString("arriving_soon", comment: "")
        } else if let minutes = minutesRemaining, minutes >= 1 {
            return String(format: NSLocalizedString("minutes_remaining", comment: ""), minutes)
        } else if let minutes = minutesRemaining, minutes < 1 && minutes > 0 {
            return NSLocalizedString("arriving_soon", comment: "")
        } else if let stations = stationsRemaining {
            return String(format: NSLocalizedString("stations_remaining", comment: ""), stations)
        } else if status.contains(arrivalStationName) {
            return status.replacingOccurrences(of: arrivalStationName, with: "")
        } else {
            return status
        }
    }

    var timeOfArrival: Date? {
        guard let minutes = minutesRemaining else { return nil }
        return Date().addingTimeInterval(TimeInterval(minutes * 60))
    }

}
