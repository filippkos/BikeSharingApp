//
//  LocationService.swift
//  BikeSharingApp
//
//  Created by Filipp Kosenko on 24.10.2023.
//

import Foundation
import CoreLocation



protocol LocationReceiveDelegate: AnyObject {
    func receive(location: (Double, Double)?)
}

final class LocationService: NSObject, CLLocationManagerDelegate {
    
    // MARK: -
    // MARK: Variables
    
    var locationManager: CLLocationManager
    var currentLocation: (Double, Double)
    weak var locationReceiver: LocationReceiveDelegate?
    
    // MARK: -
    // MARK: Init
    
    init(locationManager: CLLocationManager = CLLocationManager()) {
        self.locationManager = locationManager
        self.currentLocation = (0,0)
        super.init()
        self.locationServiceSetup()
    }
    
    // MARK: -
    // MARK: Internal
    
    func requestLocation() {
        self.locationManager.requestLocation()
    }
    
    // MARK: -
    // MARK: Private
    
    private func locationServiceSetup() {
        locationManager = CLLocationManager()
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()
    }
    
    // MARK: -
    // MARK: CLLocationManagerDelegate
    
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        if status == .authorizedWhenInUse {
            locationManager.requestLocation()
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        
        print("error:: \(error.localizedDescription)")
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let location = locations.first {
            let latitude = location.coordinate.latitude
            let longitude = location.coordinate.longitude
            self.currentLocation = (latitude, longitude)
            self.locationReceiver?.receive(location: (latitude, longitude))
        } else {
            self.locationReceiver?.receive(location: nil)
        }
    }
}
