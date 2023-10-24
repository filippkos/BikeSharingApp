//
//  ServiceManager.swift
//  BikeSharingApp
//
//  Created by Filipp Kosenko on 24.10.2023.
//

import Foundation

final class ServiceManager {
    
    // MARK: -
    // MARK: Variables
    
    public let networkManager: NetworkManager
    public let locationService: LocationService

    // MARK: -
    // MARK: Init
    
    public init(networkManager: NetworkManager, locationService: LocationService) {
        self.networkManager = networkManager
        self.locationService = locationService
    }
}
