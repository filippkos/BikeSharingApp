//
//  Coordinator.swift
//  BikeSharingApp
//
//  Created by Filipp Kosenko on 23.10.2023.
//

import UIKit

public protocol Coordinator: AnyObject {
    
    var navigationViewController: UINavigationController { get set }
    
    func presentAlert(alertModel: AlertModel, controller: UIViewController?)
}

class AppCoordinator: Coordinator {
    
    // MARK: -
    // MARK: Variables
    
    var navigationViewController: UINavigationController
    
    let serviceManager: ServiceManager
    
    // MARK: -
    // MARK: Init
    
    init(navigationController: UINavigationController, serviceManager: ServiceManager) {
        self.navigationViewController = navigationController
        self.serviceManager = serviceManager
        self.navigationViewController.navigationBar.isHidden = true
        self.prepareContainerViewController()
    }
    
    // MARK: -
    // MARK: Private
    
    private func prepareContainerViewController() {
        let controller = StationListViewController(serviceManager: self.serviceManager)
        controller.outputEvents = { [weak self] event in
            self?.handle(event: event, controller: controller)
        }
        self.navigationViewController.setViewControllers([controller], animated: true)
    }
    
    private func handle(event: StationListViewControllerOutputEvents, controller: UIViewController) {
        switch event {
        case let .needShowAlert(alertModel):
            self.presentAlert(alertModel: alertModel, controller: controller)
        }
    }
}
