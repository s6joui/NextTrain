//
//  SubwayInfoDataProvider.swift
//  NextTrain
//
//  Created by Joey on 3/11/21.
//

import Foundation
import UIKit

protocol SubwayInfoDataProvider {
    var stations: [SubwayStation] { get }
    func fetchStation(from query: String) -> SubwayStation
    func lineName(from id: String?) -> String
    func lineColor(from id: String?) -> UIColor
}
