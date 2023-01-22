//
//  RouletteScreenViewModel.swift
//  WorldTravelRoulette
//
//  Created by mikaurakawa on 2023/01/19.
//

import Foundation
import MapKit

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
    @Published var selectedRegion = MKCoordinateRegion(
        center: CLLocationCoordinate2D(
            latitude: 35.68,  // 日本
            longitude: 139.75  // 日本
        ),
        latitudinalMeters: 1000 * 1000,
        longitudinalMeters: 1000 * 1000
    )

    func startRoulette() {
        rouletteStatus = .rolling
        DispatchQueue.main.asyncAfter(deadline: .now() + 3.0) { [weak self] in
            guard let self = self else { return }
            self.rouletteStatus = .endRolling

            // TODO: 仮実装
            self.selectedCountry = Country(commonName: "british", commonNameJa: "イギリス", flagPng: "https://flagcdn.com/w320/zm.png", googleMapURL: "https://goo.gl/maps/mweBcqvW8TppZW6q9", capitalLocation: Location(lat: 51.5, lng: -0.08))
            self.selectedRegion = MKCoordinateRegion(
                center: CLLocationCoordinate2D(
                    latitude: 51.5,
                    longitude: -0.08
                ),
                latitudinalMeters: 1000 * 1000,
                longitudinalMeters: 1000 * 1000
            )

            // 行ったことがある国を取得する

            // 行ったことのない国を取得

            // 行ったことのない国からランダムで選択する
        }
    }
}
