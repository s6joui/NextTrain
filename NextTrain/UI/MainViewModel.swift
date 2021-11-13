//
//  MainViewModel.swift
//  NextTrain
//
//  Created by Joey on 3/11/21.
//

import Foundation

class MainViewModel {

    let arrivalDataProvider: ArrivalDataProvider!
    let subwayInfoProvider: SubwayInfoDataProvider!
    let stationCsvReader: StationDataCsvReader!

    var stationInfo: [SubwayStation]?
    var arrivals = Observable<[LineCardViewModel]>(nil)
    var arrivalsLoading = Observable<Bool>(true)
    var arrivalsError = Observable<Error?>(nil)

    init(
        arrivalDataProvider: ArrivalDataProvider,
        subwayInfoProvider: SubwayInfoDataProvider,
        stationCsvReader: StationDataCsvReader
    ) {
        self.arrivalDataProvider = arrivalDataProvider
        self.subwayInfoProvider = subwayInfoProvider
        self.stationCsvReader = stationCsvReader
        stationInfo = try? stationCsvReader.readFile(fileName: "station_data")
    }

    func fetchArrivalInfo(for station: String) {
        arrivalsLoading.value = true
        Task {
            do {
                try await Task.sleep(nanoseconds: 500_000_000)
                let arrivalInfo = try await arrivalDataProvider.fetchArrivalInfo(for: station)
                var data: [LineCardViewModel] = []
                arrivalInfo.forEach { info in
                    guard let subwayHeading = info.subwayHeading else { return }
                    let lineName = subwayInfoProvider.lineName(from: info.subwayId)
                    let lineColor = subwayInfoProvider.lineColor(from: info.subwayId)
                    let trainNumber = info.btrainNo ?? ""
                    let vm = ArrivalCardViewModel(
                        lineName: lineName,
                        trainNumber: trainNumber,
                        status: info.arvlMsg2 ?? "",
                        currentStationName: info.arvlMsg3 ?? "",
                        baseStation: info.bstatnNm ?? "",
                        direction: info.updnLine ?? "",
                        heading: subwayHeading,
                        lineColor: lineColor
                    )
                    if let line = data.firstIndex(where: { $0.lineName == lineName }) {
                        data[line].arrivals.append(vm)
                    } else {
                        let nextStation = stationInfo?.first(where: { $0.id == info.statnFid })
                        let previousStation = stationInfo?.first(where: { $0.id == info.statnTid })
                        data.append(
                            LineCardViewModel(
                                lineName: lineName,
                                stationName: station,
                                nextStation: nextStation?.name ?? "",
                                previousStation: previousStation?.name ?? "",
                                arrivals: [vm],
                                lineColor: lineColor
                            )
                        )
                    }
                }
                arrivals.value = data.sorted(by: { $1.lineName > $0.lineName })
                arrivalsLoading.value = false
            } catch {
                arrivalsError.value = error
                arrivalsLoading.value = false
            }
        }
    }

}
