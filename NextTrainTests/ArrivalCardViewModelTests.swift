//
//  ArrivalCardViewModelTests.swift
//  NextTrainTests
//
//  Created by Joey on 8/11/21.
//

import XCTest
@testable import NextTrain

class ArrivalCardViewModelTests: XCTestCase {

    var sut: ArrivalCardViewModel!

    func testMessage_StatusWithRemainingSationInfo_RemainingSationMessageResult() throws {
        sut = buildViewModel(withStatus: "[5]번째 전역 (강매)")

        let msg = sut.message

        XCTAssertTrue(msg == String(format: localizedString("stations_remaining"), 5))
    }

    func testMessage_StatusWithRemainingSationInfoAndNumberInStationName_RemainingSationMessage() throws {
        sut = buildViewModel(withStatus: "[8]2번째 전역 (강매2)")

        let msg = sut.message

        XCTAssertTrue(msg == String(format: localizedString("stations_remaining"), 8))
    }

    func testMessage_UnknownStatus_MessageReplicated() throws {
        sut = buildViewModel(withStatus: "시험TEST")

        let msg = sut.message

        XCTAssertTrue(msg == "시험TEST")
    }

    func testMessage_UnknownStatusWithNumber_MessageReplicated() throws {
        sut = buildViewModel(withStatus: "인천공항2터미널")

        let msg = sut.message

        XCTAssertTrue(msg == "인천공항2터미널")
    }

    func testMessage_StatusWithRemaining1MinuteInformation_1MinuteRemainingMessage() throws {
        sut = buildViewModel(withStatus: "1분 18초 후")

        let msg = sut.message

        XCTAssertTrue(msg == String(format: localizedString("minutes_remaining"), 1.0))
    }

    func testMessage_StatusWithRemainingSecondsInformation_ArrivingSoonMessage() throws {
        sut = buildViewModel(withStatus: "38초 후")

        let msg = sut.message

        XCTAssertTrue(msg == String(format: localizedString("arriving_soon")))
    }

    func testMessage_StatusWithRemaining3MinutesInformation_3MinuteRemainingMessage() throws {
        sut = buildViewModel(withStatus: "3분 46초 후")

        let msg = sut.message

        XCTAssertTrue(msg == String(format: localizedString("minutes_remaining"), 3.0))
    }

    func testMessage_StatusArrivedAtStation_MessageReplicated() throws {
        sut = buildViewModel(withStatus: "합정 도착")

        let msg = sut.message

        XCTAssertTrue(msg == "합정 도착")
    }

    func testMessage_StatusWithPreviousStationInformation_ArrivingSoonMessage() throws {
        sut = buildViewModel(withStatus: "전역 도착")

        let msg = sut.message

        XCTAssertTrue(msg == localizedString("arriving_soon"))
    }

    func testTimeOfArrival_StatusEnteringPreviousStation_TimeOfArrival3MinutesLater() throws {
        sut = buildViewModel(withStatus: "전역 진입")

        let timeOfArrival = sut.timeOfArrival

        let expectedTimeOfArrival = Date().addingTimeInterval(3 * 60)
        XCTAssertEqual(
            expectedTimeOfArrival.timeIntervalSince1970,
            timeOfArrival!.timeIntervalSince1970,
            accuracy: 0.001
        )
    }

    func testTimeOfArrival_Status6minutesRemaining_TimeOfArrival6MinutesLater() throws {
        sut = buildViewModel(withStatus: "6분 46초 후")

        let timeOfArrival = sut.timeOfArrival

        let expectedTimeOfArrival = Date().addingTimeInterval(6 * 60)
        XCTAssertEqual(
            expectedTimeOfArrival.timeIntervalSince1970,
            timeOfArrival!.timeIntervalSince1970,
            accuracy: 0.001
        )
    }

    func testTimeOfArrival_StatusArrivedAtPreviousStation_TimeOfArrival2MinutesLater() throws {
        sut = buildViewModel(withStatus: "전역 도착")

        let timeOfArrival = sut.timeOfArrival

        let expectedTimeOfArrival = Date().addingTimeInterval(2 * 60)
        XCTAssertEqual(
            expectedTimeOfArrival.timeIntervalSince1970,
            timeOfArrival!.timeIntervalSince1970,
            accuracy: 0.001
        )
    }

    func testTimeOfArrival_UnknownStatus_NilTimeOfArrival() throws {
        sut = buildViewModel(withStatus: "423fewf235fdfq23r2r2r2r3rdfwd")

        let timeOfArrival = sut.timeOfArrival

        XCTAssertNil(timeOfArrival)
    }

    func testTimeOfArrival_EmptyStatus_NilTimeOfArrival() throws {
        sut = buildViewModel(withStatus: "")

        let timeOfArrival = sut.timeOfArrival

        XCTAssertNil(timeOfArrival)
    }

    func buildViewModel(withStatus status: String) -> ArrivalCardViewModel {
        return ArrivalCardViewModel(
            lineName: "2",
            trainNumber: "123123",
            status: status,
            currentLocation: "이촌",
            baseStation: "용문",
            direction: "이촌",
            heading: .left,
            lineColor: .red,
            arrivalStationName: "홍대입구"
        )
    }

    func localizedString(_ key: String) -> String {
        return NSLocalizedString(key, comment: "")
    }

}
