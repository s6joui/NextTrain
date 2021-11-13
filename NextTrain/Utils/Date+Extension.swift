//
//  Date+Extension.swift
//  NextTrain
//
//  Created by Joey on 13/11/21.
//

import Foundation

extension Date {

    func hourMinuteFormattedString() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.calendar = Calendar(identifier: .gregorian)
        dateFormatter.locale = Locale(identifier: "ko_KR")
        dateFormatter.dateFormat = "H:mm"
        return dateFormatter.string(from: self)
    }

}
