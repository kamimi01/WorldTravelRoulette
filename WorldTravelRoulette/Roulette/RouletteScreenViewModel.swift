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
    @Published var selectedCountry: Country? = nil

    func startRoulette() {
        rouletteStatus = .rolling
        DispatchQueue.main.asyncAfter(deadline: .now() + 3.0) {
            self.rouletteStatus = .endRolling
        }

        // 行ったことがある都道府県を取得する

        // 行ったことのない都道府県を取得

        // 行ったことのない都道府県からランダムで選択する
    }
}
