//
//  RestCountry.swift
//  WorldTravelRoulette
//
//  Created by mikaurakawa on 2023/01/19.
//

import Foundation

struct RestCountry: Decodable {
    let name: Name
    let translations: Translation
    let flags: Flags
    let maps: Maps
}

struct Name: Decodable {
    let common: String
}

struct Translation: Decodable {
    let jpn: JpnName?
}

struct JpnName: Decodable {
    let common: String
}

struct Flags: Decodable {
    let png: String
}

struct Maps: Decodable {
    let googleMaps: String
}
