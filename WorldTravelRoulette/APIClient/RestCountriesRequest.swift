//
//  RestCountriesRequest.swift
//  WorldTravelRoulette
//
//  Created by mikaurakawa on 2023/01/19.
//

import Foundation

protocol RestCountriesRequest {
    associatedtype Response: Decodable

    var baseURL: URL { get }
    var path: String { get }
    var method: HTTPMethod { get }
}

extension RestCountriesRequest {
    var baseURL: URL {
        return URL(string: "https://restcountries.com/v3.1")!
    }

    func buildURLRequest() -> URLRequest {
        // TODO
    }

    func response(from data: Data) -> Response {
        // TODO
    }
}
