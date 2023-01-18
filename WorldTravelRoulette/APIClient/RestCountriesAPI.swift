//
//  RestCountriesAPI.swift
//  WorldTravelRoulette
//
//  Created by mikaurakawa on 2023/01/19.
//

import Foundation

class RestCountriesAPI {
    struct GetAllCountries: RestCountriesRequest {
        typealias Response = [RestCountry]

        var method: HTTPMethod {
            return .get
        }

        var path: String {
            return "/all"
        }
    }
}
