//
//  FullModel.swift
//  BikeSharingApp
//
//  Created by Filipp Kosenko on 23.10.2023.
//

import Foundation

// MARK: -
// MARK: FullModel

struct FullModel: Codable {
    let network: Network
}

// MARK: -
// MARK: Network

struct Network: Codable {
    let company: [String]
    let href, id: String
    let location: Location
    let name: String
    let stations: [Station]
}

// MARK: -
// MARK: Location

struct Location: Codable {
    let city, country: String
    let latitude, longitude: Double
}

// MARK: -
// MARK: Station

struct Station: Codable {
    let emptySlots: Int?
    let freeBikes: Int
    let id: String
    let latitude, longitude: Double
    let name, timestamp: String

    enum CodingKeys: String, CodingKey {
        case emptySlots = "empty_slots"
        case freeBikes = "free_bikes"
        case id, latitude, longitude, name, timestamp
    }
}
