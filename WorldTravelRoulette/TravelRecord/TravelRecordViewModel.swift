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

enum RetreiveStatus {
    case empty
    case loading
    case success
    case failure
}

class TravelRecordViewModel: ObservableObject {
    @Published var countries = [Country]()
    @Published var retreiveStatus = RetreiveStatus.empty

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

        retreiveStatus = .loading
        client.send(request: request) { [weak self] result in
            guard let self = self else { return }
            switch result {
            case let .success(response):
                print(response)
                DispatchQueue.main.async {
                    self.countries = self.convertType(from: response)
                    self.retreiveStatus = .success
                }
            case let .failure(error):
                print(error)
                DispatchQueue.main.async {
                    self.retreiveStatus = .failure
                }
            }
        }
    }

    private func convertType(from restCountries: [RestCountry]) -> [Country] {
        var tmpCountries = [Country]()

        restCountries.forEach {
            let country = Country(
                commonName: $0.name.common,
                commonNameJa: $0.translations.jpn?.common,
                flagPng: $0.flags.png,
                googleMapURL: $0.maps.googleMaps,
                capitalLocation: Location(
                    lat: $0.capitalInfo.latlang?[safe: 0],
                    lng: $0.capitalInfo.latlang?[safe: 1]
                )
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
