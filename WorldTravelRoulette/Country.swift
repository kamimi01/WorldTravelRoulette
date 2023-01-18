//
//  Country.swift
//  WorldTravelRoulette
//
//  Created by mikaurakawa on 2023/01/19.
//

import Foundation

struct Country: Identifiable {
    let id = UUID().uuidString
    let commonNameJa: String
    let flagPng: String
}
