//
//  RouletteScreenViewModel.swift
//  WorldTravelRoulette
//
//  Created by mikaurakawa on 2023/01/19.
//

import Foundation

enum RouletteStatus {
    case notRolling
    case rolling
    case endRolling
}

class RouletteScreenViewModel: ObservableObject {
    @Published var rouletteStatus = RouletteStatus.notRolling
    @Published var selectedCountry = Country(
        commonName: "Japan",
        commonNameJa: "日本",
        flagPng: "https://flagcdn.com/w320/jp.png",
        googleMapURL: "https://goo.gl/maps/NGTLSCSrA8bMrvnX9",
        capitalLocation: Location(
            lat: 35.68,
            lng: 139.75
        )
    )

    func startRoulette() {
        rouletteStatus = .rolling
        DispatchQueue.main.asyncAfter(deadline: .now() + 3.0) {
            self.rouletteStatus = .endRolling
        }

        // TODO: 仮実装
        selectedCountry = Country(commonName: "congo", commonNameJa: "コンゴ", flagPng: "https://flagcdn.com/w320/zm.png", googleMapURL: "https://goo.gl/maps/mweBcqvW8TppZW6q9", capitalLocation: Location(lat: 51.5, lng: -0.08))

        // 行ったことがある都道府県を取得する

        // 行ったことのない都道府県を取得

        // 行ったことのない都道府県からランダムで選択する
    }
}
