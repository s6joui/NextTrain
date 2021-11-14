//
//  LineCardViewModel.swift
//  NextTrain
//
//  Created by Joey on 14/11/21.
//

import UIKit

struct LineCardViewModel {

    let lineName: String
    let stationName: String
    let nextStation: String
    let previousStation: String
    var arrivals: [ArrivalCardViewModel]
    let lineColor: UIColor

}
