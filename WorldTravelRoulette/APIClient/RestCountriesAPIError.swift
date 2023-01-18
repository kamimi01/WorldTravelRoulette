//
//  RestCountriesAPIError.swift
//  WorldTravelRoulette
//
//  Created by mikaurakawa on 2023/01/19.
//

import Foundation

struct RestCountriesAPIError: Decodable, Error {
    let message: String
}
