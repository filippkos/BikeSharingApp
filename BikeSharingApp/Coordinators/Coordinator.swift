//
//  Coordinator.swift
//  BikeSharingApp
//
//  Created by Filipp Kosenko on 23.10.2023.
//

import UIKit

class Coordinator {
    
    // MARK: -
    // MARK: Variables
    
    let navigationController: UINavigationController
    let serviceManager: ServiceManager
    
    // MARK: -
    // MARK: Init
    
    init(navigationController: UINavigationController, serviceManager: ServiceManager) {
        self.navigationController = navigationController
        self.serviceManager = serviceManager
        self.navigationController.navigationBar.isHidden = true
        self.prepareContainerViewController()
    }
    
    // MARK: -
    // MARK: Private
    
    private func prepareContainerViewController() {
        let controller = StationListViewController(serviceManager: self.serviceManager)
        
        self.navigationController.setViewControllers([controller], animated: true)
    }
}
