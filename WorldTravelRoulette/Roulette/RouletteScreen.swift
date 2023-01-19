//
//  RouletteScreen.swift
//  WorldTravelRoulette
//
//  Created by mikaurakawa on 2023/01/19.
//

import SwiftUI

struct RouletteScreen: View {
    @ObservedObject var viewModel = RouletteScreenViewModel()

    var body: some View {

        NavigationView {
            VStack(spacing: 20) {
                switch viewModel.rouletteStatus {
                case .notRolling:
                    Text("ボタンを押してね👇")
                        .font(.title)
                        .frame(maxWidth: .infinity)
                        .frame(height: 100)
                case .rolling:
                    LottieView(animationType: .oneTwoThree)
                        .frame(width: 100, height: 100)
                case .endRolling:
                    VStack(alignment: .center, spacing: 5) {
                        if let selectedCountry = viewModel.selectedCountry {
                            Text(selectedCountry.commonNameJa)
                                .font(.title)
                            Text("\nにいこう！")
                                .font(.title2)
                        } else {
                            Text("全部行ったね！すごい！🎉")
                                .font(.title)
                        }
                    }
                    .frame(maxWidth: .infinity)
                    .frame(height: 100)
                }
                HStack {
                    Image("")
                    Image("")
                }
                Button(action: {
                    viewModel.startRoulette()
                }) {
                    Text("旅をする")
                        .font(.title)
                        .frame(width: 200, height: 200)
                        .imageScale(.large)
                        .background(Color.green)
                        .foregroundColor(.white)
                        .clipShape(Circle())
                        .shadow(color: .gray, radius: 3, x: 5, y: 5)
                }
            }
            .navigationTitle("次はどこへ行く？")
            .navigationBarTitleDisplayMode(.inline)
        }
    }
}

struct RouletteScreen_Previews: PreviewProvider {
    static var previews: some View {
        RouletteScreen()
    }
}
