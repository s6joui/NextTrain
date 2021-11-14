//
//  FakeData.swift
//  NextTrainTests
//
//  Created by Joey on 14/11/21.
//

import Foundation
@testable import NextTrain

struct FakeData {

    static let fakeStation = SubwayStation(id: "1002000213", name: "구의")

    static let fakeArrival1 = ArrivalInfo(
        subwayId: "1002",
        statnNm: "1002000213",
        subwayHeading: .right,
        trainLineNm: "1002",
        updnLine: "TEST",
        bstatnNm: "TEST_B_STAT",
        btrainNo: "21234",
        arvlMsg2: "1분 후",
        arvlMsg3: "홍대입구",
        recptnDt: "2021-11-14 01:22:00",
        statnFid: "1002000214",
        statnTid: "1002000212"
    )

    static let fakeArrival2 = ArrivalInfo(
        subwayId: "1002",
        statnNm: "1002000213",
        subwayHeading: .left,
        trainLineNm: "1002",
        updnLine: "TEST",
        bstatnNm: "TEST_B_STAT",
        btrainNo: "21234",
        arvlMsg2: "6분 후",
        arvlMsg3: "홍대입구",
        recptnDt: "2021-11-14 01:22:00",
        statnFid: "1002000212",
        statnTid: "1002000214"
    )

}
