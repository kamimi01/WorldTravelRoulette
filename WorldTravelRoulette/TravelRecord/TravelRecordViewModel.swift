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
            saveSelectedCountry(country)
        case .notSelected:
            deleteSelectedCountry(country)
        }
    }

    private func getAllCountries() {
        retreiveStatus = .loading

        if let countries = loadCachedData() {
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
                    lat: $0.capitalInfo.latlang?[safe: 0],
                    lng: $0.capitalInfo.latlang?[safe: 1]
                )
            )
            tmpCountries.append(country)
        }
        return tmpCountries
    }

    private func saveCountries(_ countries: [Country]) {
        // TODO: UserDefaultsにデータを保存する
        // 保存方法1: CountryにisSelectedを持たせて、その値を書き換えることで状態を管理する（データを全て取り出す→書き換えたい値を探す→isSelectedを書き換える→保存する）
        // TODO: エンコードしてData型の配列を作成する
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
        // TODO: UserDefaultsのisSelectedをtrueに書き換える
        // 1. UserDefaultsから全データを取得する
        let countries = loadCachedData()
    }

    private func deleteSelectedCountry(_ country: Country) {
        // TODO: UserDefaultsのisSelectedをfalseに書き換える
        let countries = loadCachedData()
    }

    private func loadCachedData() -> [Country]? {
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
