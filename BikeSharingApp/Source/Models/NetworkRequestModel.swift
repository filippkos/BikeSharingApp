//
//  NetworkRequestModel.swift
//  BikeSharingApp
//
//  Created by Filipp Kosenko on 23.10.2023.
//

import Foundation

public enum HttpMethod: String {
    
    case get = "GET"
    case post = "POST"
    case put = "PUT"
    case delete = "DELETE"
}

struct NetworkRequestModel {
    
    // MARK: -
    // MARK: Variables
    
    var urlComponents: URLComponents
    var params: [String : String]?
    var endPoint: String?
    var httpMethod: HttpMethod = .get
    var request: URLRequest {
        let urlComponents = self.createUrlComponents(urlComponents: urlComponents, params: params, endPoint: endPoint)
        var request = URLRequest(url: urlComponents.url ?? URL(fileURLWithPath: ""))
        request.httpMethod = (HttpMethod.get).rawValue
        
        return request
    }
    
    // MARK: -
    // MARK: Private
    
    private func createUrlComponents(urlComponents: URLComponents, params: [String : String]?, endPoint: String?) -> URLComponents {
        var components = urlComponents
        
        if let params = params {
            components.queryItems = params.map {
                URLQueryItem(name: $0.key, value: $0.value)
            }
        }
        
        if let endPoint = endPoint {
            components.path += endPoint
        }
        
        return components
    }
}
