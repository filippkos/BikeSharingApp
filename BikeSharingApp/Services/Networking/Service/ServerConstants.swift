//
//  ServerConstants.swift
//  BikeSharingApp
//
//  Created by Filipp Kosenko on 23.10.2023.
//

import Foundation

struct ServerConstants {
    
    static func createComponents() -> URLComponents {
        var mainComponents = URLComponents()
        mainComponents.scheme = "https"
        mainComponents.host = "api.citybik.es"
        mainComponents.path = "/v2/networks/"
        
        return mainComponents
    }
}
