//
//  Country.swift
//  WorldTravelRoulette
//
//  Created by mikaurakawa on 2023/01/19.
//

import Foundation

struct Country: Identifiable, Codable {
    let id = UUID().uuidString
    let commonName: String
    let commonNameJa: String?
    let flagPng: String
    let googleMapURL: String
    let capitalLocation: Location
    var isSelected: Bool = false
}

struct Location: Codable {
    let lat: Double?
    let lng: Double?
}
