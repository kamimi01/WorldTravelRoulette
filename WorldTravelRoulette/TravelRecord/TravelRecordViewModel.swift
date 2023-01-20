//
//  TravelRecordViewModel.swift
//  WorldTravelRoulette
//
//  Created by mikaurakawa on 2023/01/20.
//

import Foundation

enum ButtonStatus {
    case selected
    case notSelected
}

class TravelRecordViewModel: ObservableObject {
    @Published var countries = [Country]()

    func onAppear() {
        getAllCountries()
    }

    func isSavedCountry(country: Country) -> Bool {
        return true
    }

    func didTapButton(buttonStatus: ButtonStatus, country: Country) {
        switch buttonStatus {
        case .selected:
            saveSelectedCountry(country: country)
        case .notSelected:
            deleteSelectedCountry(country: country)
        }
    }

    private func getAllCountries() {
        let client = RestCountriesClient()
        let request = RestCountriesAPI.GetAllCountries()

        client.send(request: request) { [weak self] result in
            guard let self = self else { return }
            switch result {
            case let .success(response):
                print(response)
                DispatchQueue.main.async {
                    self.countries = self.convertType(from: response)
                }
            case let .failure(error):
                print(error)
            }
        }
    }

    private func convertType(from restCountries: [RestCountry]) -> [Country] {
        var tmpCountries = [Country]()

        restCountries.forEach {
            let country = Country(
                commonName: $0.name.common,
                commonNameJa: $0.translations.jpn?.common,
                flagPng: $0.flags.png
            )
            tmpCountries.append(country)
        }
        return tmpCountries
    }

    private func saveSelectedCountry(country: Country) {

    }

    private func deleteSelectedCountry(country: Country) {

    }
}
