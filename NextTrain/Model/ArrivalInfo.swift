//
//  ArrivalInfo.swift
//  NextTrain
//
//  Created by Joey on 3/11/21.
//

import Foundation

enum SubwayHeading: String, Codable {
    case left = "왼쪽"
    case right = "오른쪽"
}

struct ArrivalInfoResponse: Codable {
    let realtimeArrivalList: [ArrivalInfo]?
    let errorMessage: SubwayApiError?
    let status: Int?
    let code: String?
    let message: String?
}

struct ArrivalInfo: Codable {
    let subwayId: String?
    let statnNm: String?
    let subwayHeading: SubwayHeading?
    let trainLineNm: String?
    let updnLine: String?
    let bstatnNm: String?
    let btrainNo: String?
    let arvlMsg2: String?
    let arvlMsg3: String?
    let recptnDt: String?
    let statnFid: String?
    let statnTid: String?
}
