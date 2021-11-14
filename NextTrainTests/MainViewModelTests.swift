//
//  MainViewModelTests.swift
//  NextTrainTests
//
//  Created by Joey on 14/11/21.
//

import XCTest
@testable import NextTrain

class MainViewModelTests: XCTestCase {

    let mockArrivalDataProvider = MockArrivalDataProvider()
    let mockSubwayInfoDataProvider = MockSubwayInfoDataProvider()

    lazy var sut: MainViewModel = MainViewModel(
        arrivalDataProvider: mockArrivalDataProvider,
        subwayInfoProvider: mockSubwayInfoDataProvider,
        stationCsvReader: StationDataCsvReader()
    )

    func testFetchArrivals_NoResults_ErrorReturned() async throws {
        mockArrivalDataProvider.thrownError = .missingData(message: "No results")

        let expectation = XCTestExpectation(description: "Error is not nil")

        sut.fetchArrivalInfo(for: "STATION")
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) { [sut] in
            XCTAssertNotNil(sut.arrivalsError.value)
            expectation.fulfill()
        }

        wait(for: [expectation], timeout: 2)
    }

    func testFetchArrivals_ResultsAvailable_ErrorIsNil() async throws {
        mockArrivalDataProvider.thrownError = nil

        let expectation = XCTestExpectation(description: "Error is nil")

        sut.fetchArrivalInfo(for: "STATION")
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) { [sut] in
            XCTAssertNil(sut.arrivalsError.value)
            expectation.fulfill()
        }

        wait(for: [expectation], timeout: 2)
    }

    func testFetchArrivals_ResultsAvailable_LoadingIsFalseAfterLoadingData() async throws {
        mockArrivalDataProvider.thrownError = nil

        let expectation = XCTestExpectation(description: "Loading will be set to false after loading data.")

        sut.fetchArrivalInfo(for: "STATION")
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) { [sut] in
            XCTAssertTrue(sut.arrivalsLoading.value == false)
            expectation.fulfill()
        }

        wait(for: [expectation], timeout: 2)
    }

    func testFetchArrivals_Error_LoadingIsFalseAfterThrowingError() async throws {
        mockArrivalDataProvider.thrownError = .missingData(message: "No data")

        let expectation = XCTestExpectation(description: "Loading will be set to false after throwing error.")

        sut.fetchArrivalInfo(for: "STATION")
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) { [sut] in
            XCTAssertTrue(sut.arrivalsLoading.value == false)
            expectation.fulfill()
        }

        wait(for: [expectation], timeout: 2)
    }

    func testFetchArrivals_ResultsAvailable_ResultsTransformed() async throws {
        mockArrivalDataProvider.thrownError = nil
        mockArrivalDataProvider.fakeData = [FakeData.fakeArrival1, FakeData.fakeArrival2]

        let expectation = XCTestExpectation(description: "Results are transformed to LineCardViewModels")

        sut.fetchArrivalInfo(for: "STATION")
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) { [sut] in
            let results = sut.arrivals.value
            let firstResult = results?.first
            XCTAssertTrue(firstResult?.arrivals.count == 2)
            expectation.fulfill()
        }

        wait(for: [expectation], timeout: 2)
    }

}

class MockArrivalDataProvider: ArrivalDataProvider {

    var thrownError: ArrivalDataProviderError?
    var fakeData: [ArrivalInfo] = []

    func fetchArrivalInfo(for stationName: String) async throws -> [ArrivalInfo] {
        if let error = thrownError {
            throw error
        }
        return fakeData
    }

}

class MockSubwayInfoDataProvider: SubwayInfoDataProvider {

    func fetchStation(from query: String) -> SubwayStation {
        return FakeData.fakeStation
    }

    func lineName(from id: String?) -> String {
        return "2"
    }

    func lineColor(from id: String?) -> UIColor {
        return .green
    }

}
