//
//  SubwayApiError.swift
//  NextTrain
//
//  Created by Joey on 3/11/21.
//

import Foundation

struct SubwayApiError: Codable {
    let status: Int?
    let code: String?
    let message: String?
}
