//
//  DataManager.swift
//  WorldTravelRoulette
//
//  Created by mikaurakawa on 2023/01/23.
//

import Foundation

class DataManager {
    init() {}

    static func loadCachedData() -> [Country]? {
        guard let datas = UserDefaults.standard.array(forKey: "countries") as? [Data] else {
            return nil
        }

        var countries = [Country]()
        datas.forEach {
            guard let country = try? JSONDecoder().decode(Country.self, from: $0) else {
                fatalError("failed to decode")
            }
            countries.append(country)
        }
        return countries
    }
}
