//
//  NetworkManager.swift
//  BikeSharingApp
//
//  Created by Filipp Kosenko on 23.10.2023.
//

import Foundation

fileprivate enum NetworkError: String, LocalizedError {
    case noData
    case wrongCode
    
    var errorDescription: String? {
        self.rawValue
    }
}

final class NetworkManager {
    
    @discardableResult
    func task<Model>(requestModel: NetworkRequestModel, completion: @escaping F.ResultHandler<Model>) -> URLSessionDataTask  where Model : Decodable, Model : Encodable {
        let session = URLSession.shared
        let task = session.dataTask(with: requestModel.request) { data, response, error in
            if let error = error {
                completion(.failure(error))
            }
            let response = response as! HTTPURLResponse
            let code = response.statusCode
            if code != 200 {
                completion(.failure(NetworkError.wrongCode))
            } else {
                if let data = data {
                    completion(self.decode(data: data))
                } else {
                    completion(.failure(NetworkError.noData))
                }
            }
        }
        task.resume()
        
        return task
    }
    
    private func decode<Model: Codable>(data: Data, decoder: JSONDecoder = JSONDecoder()) -> Result<Model, Error> {
        do {
            return .success(try decoder.decode(Model.self, from: data))
        } catch {
            debugPrint("***Parser log - \(error)")
            
            return .failure(error)
        }
    }
}
