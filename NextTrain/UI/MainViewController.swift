//
//  MainViewController.swift
//  NextTrain
//
//  Created by Joey on 3/11/21.
//

import UIKit

class MainViewController: UIViewController {

    let viewModel: MainViewModel!

    let tableView: UITableView = {
        let tableView = UITableView()
        tableView.separatorColor = .clear
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }()

    let refreshControl = UIRefreshControl()
    let searchResultsController = StationSearchResultsViewController()
    lazy var searchController = UISearchController(searchResultsController: searchResultsController)

    var currentStation = "홍대입구" //홍대입구 합정 마포 서울 디지털미디어시티
    var lineInfo: [LineCardViewModel] = []

    weak var timer: Timer?

    init(viewModel: MainViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .white
        setupTitle()
        setupSearch()

        refreshControl.addTarget(self, action: #selector(didPullToRefresh), for: .valueChanged)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.refreshControl = refreshControl
        tableView.register(LineCardCell.self, forCellReuseIdentifier: "LineCardCell")

        view.addSubview(tableView)

        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.topAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ])

        bindViewModel()

        fetchLatestData()

        timer?.invalidate()
        timer = Timer.scheduledTimer(withTimeInterval: 60.0, repeats: true) { [weak self] _ in
            self?.fetchLatestData()
        }
    }

    func fetchLatestData() {
        lineInfo = []
        tableView.reloadData()
        viewModel.fetchArrivalInfo(for: currentStation)
    }

    func setupTitle() {
        title = currentStation
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationController?.navigationBar.largeTitleTextAttributes = [
            .font: UIFont.boldSystemFont(ofSize: 44),
        ]
    }

    func setupSearch() {
        searchResultsController.delegate = self
        searchController.searchBar.placeholder = NSLocalizedString("station_name", comment: "")
        searchController.searchBar.delegate = self
        searchController.delegate = self
        searchController.obscuresBackgroundDuringPresentation = false
        navigationItem.searchController = searchController
        navigationItem.hidesSearchBarWhenScrolling = false
        definesPresentationContext = true
    }

    func bindViewModel() {
        viewModel.arrivals.bind { [weak self] data in
            guard let data = data else { return }
            self?.lineInfo = data
            self?.tableView.reloadData()
        }
        viewModel.arrivalsError.bind{ [weak self] error in
            print(error as Any)
            self?.refreshControl.endRefreshing()
        }
        viewModel.arrivalsLoading.bind{ [weak self] loading in
            if loading == true {
                self?.refreshControl.beginRefreshing()
            } else {
                self?.refreshControl.endRefreshing()
            }
        }
    }

    @objc func didPullToRefresh() {
        fetchLatestData()
    }

    deinit {
        timer?.invalidate()
    }

}

// MARK: TableView

extension MainViewController: UITableViewDelegate, UITableViewDataSource {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return lineInfo.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "LineCardCell") as? LineCardCell else {
            return UITableViewCell()
        }

        let info = lineInfo[indexPath.row]
        cell.configure(with: info)
        return cell
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }

}

// MARK: SearchBar

extension MainViewController: UISearchBarDelegate, UISearchControllerDelegate, StationSearchDelegate {

    public func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        guard let query = searchBar.text else { return }

        let results = viewModel.stationInfo?.filter{ $0.name.contains(query) }.compactMap{ $0.name }

        let controller = searchController.searchResultsController as? StationSearchResultsViewController
        controller?.results = results ?? []
    }

    func didSelectStation(stationName: String) {
        searchController.isActive = false
        currentStation = stationName
        title = stationName
        fetchLatestData()
    }

}
