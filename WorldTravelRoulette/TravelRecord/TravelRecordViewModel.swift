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
    @Published var numOfCountries = 0

    func onAppear() {
        getAllCountries()
        getHaveBeenToCountries()
    }

    func isSavedCountry(country: Country) -> Bool {
        guard let countries = DataManager.loadCachedData() else {
            return false
        }
        if let isSelected = countries.filter({ $0.commonName == country.commonName }).first?.isSelected {
            return isSelected
        } else {
            return false
        }
    }

    func didTapButton(buttonStatus: ButtonStatus, country: Country) {
        switch buttonStatus {
        case .selected:
            saveSelectedCountry(country)
        case .notSelected:
            deleteSelectedCountry(country)
        }
    }

    private func getAllCountries() {
        retreiveStatus = .loading

        if let countries = DataManager.loadCachedData() {
            self.countries = countries
            self.retreiveStatus = .success
        } else {
            let client = RestCountriesClient()
            let request = RestCountriesAPI.GetAllCountries()

            client.send(request: request) { [weak self] result in
                guard let self = self else { return }
                switch result {
                case let .success(response):
                    print(response)
                    DispatchQueue.main.async {
                        let countries = self.convertType(from: response)
                        self.saveCountries(countries)
                        self.countries = countries
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
                    lat: $0.capitalInfo.latlng?[safe: 0],
                    lng: $0.capitalInfo.latlng?[safe: 1]
                )
            )
            tmpCountries.append(country)
        }
        return tmpCountries
    }

    private func saveCountries(_ countries: [Country]) {
        // TODO: UserDefaults???????????????????????????
        // ????????????1: Country???isSelected????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????isSelected????????????????????????????????????
        // TODO: ?????????????????????Data???????????????????????????
        var datas = [Data]()
        countries.forEach {
            guard let data = try? JSONEncoder().encode($0) else {
                fatalError("failed to encode")
            }
            datas.append(data)
        }

        UserDefaults.standard.set(datas, forKey: "countries")

        print(datas)
    }

    private func saveSelectedCountry(_ country: Country) {
        // TODO: UserDefaults???isSelected???true??????????????????
        // 1. UserDefaults?????????????????????????????????
        // 2. ?????????country???isSelected???true????????????
        guard let newCountries = changeStatus(of: true, country: country) else { return }
        // 3. ??????????????????????????????
        saveCountry(countries: newCountries)
        numOfCountries += 1
    }

    private func deleteSelectedCountry(_ country: Country) {
        // TODO: UserDefaults???isSelected???false??????????????????
        // 1. UserDefaults?????????????????????????????????
        // 2. ?????????country???isSelected???false????????????
        guard let newCountries = changeStatus(of: false, country: country) else { return }
        // 3. ??????????????????????????????
        saveCountry(countries: newCountries)
        numOfCountries -= 1
    }

    private func changeStatus(of isSelected: Bool, country: Country) -> [Country]? {
        // 1. UserDefaults?????????????????????????????????
        guard var countries = DataManager.loadCachedData() else { return nil }

        // 2. ?????????country???isSelected?????????????????????????????????
        if let index = countries.firstIndex(where: { $0.commonName == country.commonName }) {
            if countries[safe: index] != nil {
                countries[index].isSelected = isSelected
            }
        }
        return countries
    }

    private func saveCountry(countries: [Country]) {
        // ?????????????????????
        UserDefaults.standard.removeObject(forKey: "countries")
        // TODO: ???????????????
        saveCountries(countries)
    }

    private func getHaveBeenToCountries() {
        guard let countries = DataManager.loadCachedData() else { return }
        let haveBeenToCountries = countries.filter({ $0.isSelected == true })
        numOfCountries = haveBeenToCountries.count
    }
}
