//
//  StationListViewController.swift
//  BikeSharingApp
//
//  Created by Filipp Kosenko on 24.10.2023.
//

import UIKit

final class StationListViewController: UIViewController, RootViewGettable, UITableViewDataSource, UITableViewDelegate, LocationReceiveDelegate {

    typealias RootView = StationListView
    
    // MARK: -
    // MARK: Variables

    private var stations: [Station] = []
    private var refreshControl = UIRefreshControl()
    
    let serviceManager: ServiceManager
    
    // MARK: -
    // MARK: IBActions

    @IBAction func sortByNameButtonAction(_ sender: UIButton) {
        self.sortByName()
    }
    
    @IBAction func sortByDistanceButtonAction(_ sender: UIButton) {
        self.sortByDistance()
    }
    
    // MARK: -
    // MARK: Init
    
    init(serviceManager: ServiceManager) {
        self.serviceManager = serviceManager
        
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: -
    // MARK: Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.rootView?.tableView?.delegate = self
        self.rootView?.tableView?.dataSource = self
        self.serviceManager.locationService.locationReceiver = self
        
        self.rootView?.tableView?.register(cellClass: StationListTableViewCell.self)

        self.request()
        self.configureRefreshing()
    }
    
    // MARK: -
    // MARK: Handle Refresh
    
    @objc func handleRefresh(_ refreshControl: UIRefreshControl) {
        self.refreshControl.beginRefreshing()
        self.request()
        self.refreshControl.endRefreshing()
    }
    
    func configureRefreshing() {
        refreshControl.addTarget(self, action: #selector(StationListViewController.handleRefresh(_:)), for: .valueChanged)
        self.rootView?.tableView?.addSubview(self.refreshControl)
    }
    
    // MARK: -
    // MARK: Public
    
    func request() {
        self.serviceManager.networkManager.task(requestModel: self.requestModel(endPoint: "wienmobil-rad"), completion: { [weak self] (result: Result<FullModel, Error>) in
                switch result {
                case .success(let model):
                    self?.stations = model.network.stations
                    self?.serviceManager.locationService.requestLocation()
                    DispatchQueue.main.async {
                        self?.rootView?.tableView?.reloadData()
                    }
                case .failure(let error):
                    print(error)
                }
            }
        )
    }
    
    // MARK: -
    // MARK: Private
    
    private func sortByName() {
        self.stations = self.stations.sorted(by: { $0.name < $1.name })
        DispatchQueue.main.async {
            self.rootView?.tableView?.reloadData()
        }
    }
    
    private func sortByDistance() {
        self.stations = self.stations.sorted(by: {
            self.distance(to: $0) < self.distance(to: $1)
        })
        
        DispatchQueue.main.async {
            self.rootView?.tableView?.reloadData()
        }
    }
    
    private func distance(to station: Station, reference: (Double, Double)? = nil) -> Double {
        let reference = reference ?? self.serviceManager.locationService.currentLocation
        
        return sqrt(
            pow(station.latitude - reference.0, 2) +
            pow(station.longitude - reference.1, 2)
        )
    }
    
    private func requestModel(endPoint: String) -> NetworkRequestModel {
        let components = ServerConstants.createComponents()
        
        return NetworkRequestModel(urlComponents: components, endPoint: endPoint)
    }
    
    // MARK: -
    // MARK: LocationReceiveDelegate
    
    func receive(location: (Double, Double)?) {
        switch location {
        case .none:
            self.sortByName()
        case .some(_):
            self.sortByDistance()
        }
    }
    
    // MARK: -
    // MARK: UITableViewDataSource
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        self.stations.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(cellClass: StationListTableViewCell.self)
        cell.configure(with: self.stations[indexPath.row])
        
        return cell
    }
    
    // MARK: -
    // MARK: UITableViewDelegate
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let latitude = self.stations[indexPath.row].latitude
        let longitude = self.stations[indexPath.row].longitude
        if let url = URL(string: "http://maps.apple.com/?ll=\(latitude),\(longitude))") {
            UIApplication.shared.open(url, options: [:], completionHandler: nil)
        }
    }
}
