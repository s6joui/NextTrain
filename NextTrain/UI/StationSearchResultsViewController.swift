//
//  StationsSearchResultsViewController.swift
//  NextTrain
//
//  Created by Joey on 13/11/21.
//

import Foundation
import UIKit

protocol StationSearchDelegate: AnyObject {
    func didSelectStation(stationName: String)
}

class StationSearchResultsViewController: UITableViewController {

    static let itemCellId = "resultItem"
    weak var delegate: StationSearchDelegate?

    var results: [String] = [] {
        didSet {
            tableView.reloadData()
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return results.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(
            withIdentifier: StationSearchResultsViewController.itemCellId
        ) ?? UITableViewCell(style: .default, reuseIdentifier: StationSearchResultsViewController.itemCellId)

        cell.textLabel?.text = results[indexPath.row]

        return cell
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        delegate?.didSelectStation(stationName: results[indexPath.row])
    }

}
