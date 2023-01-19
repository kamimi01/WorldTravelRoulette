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

    private func saveSelectedCountry(country: Country) {

    }

    private func deleteSelectedCountry(country: Country) {

    }
}
