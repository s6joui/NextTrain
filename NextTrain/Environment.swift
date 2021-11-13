//
//  Environment.swift
//  NextTrain
//
//  Created by Joey on 13/11/21.
//

import Foundation

struct Environment {

    // MARK: Secrets

    public static let subwayApiKey = Environment.key("SubwayApiKey")

    // MARK: Utils

    private static let fileName = "Secrets"

    private static let secrets: [String: Any] = {
        guard
            let filePath = Bundle.main.path(forResource: Environment.fileName, ofType: "plist"),
            let dict = NSDictionary(contentsOfFile: filePath)
        else {
            fatalError("Secrets plist file not found. Rename 'Secrets.example.plist' to 'Secrets.plist'")
        }
        return dict as! [String: Any]
    }()

    private static func key(_  key: String) -> String {
        guard let value = Environment.secrets[key] as? String else {
            fatalError("\(key) not set in plist for this environment")
        }
        return value
    }

}
