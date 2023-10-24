//
//  AppDelegate.swift
//  BikeSharingApp
//
//  Created by Filipp Kosenko on 23.10.2023.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    // MARK: -
    // MARK: Variables

    let window = UIWindow()
    
    // MARK: -
    // MARK: Internal

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        self.prepareRootController()
        
        return true
    }
    
    // MARK: -
    // MARK: Private
    
    private func prepareRootController() {
        let navigationController = UINavigationController()
        let coordinator = AppCoordinator(navigationController: navigationController, serviceManager: self.serviceManager())
        self.window.rootViewController = navigationController
        self.window.makeKeyAndVisible()
    }
    
    private func serviceManager() -> ServiceManager {
        let networkManager = NetworkManager()
        let locationService = LocationService()
        
        return .init(
            networkManager: networkManager,
            locationService: locationService
        )
    }
}
