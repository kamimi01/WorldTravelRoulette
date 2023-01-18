//
//  RestCountriesClientError.swift
//  WorldTravelRoulette
//
//  Created by mikaurakawa on 2023/01/19.
//

import Foundation

enum RestCountriesClientError: Error {
    case connectionError(Error)
    case responseParseError(Error)
    case apiError(RestCountriesAPIError)
}
