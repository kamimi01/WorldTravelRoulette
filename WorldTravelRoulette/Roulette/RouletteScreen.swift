//
//  RouletteScreen.swift
//  WorldTravelRoulette
//
//  Created by mikaurakawa on 2023/01/19.
//

import SwiftUI
import MapKit

struct RouletteScreen: View {
    @ObservedObject var viewModel = RouletteScreenViewModel()

    var body: some View {
        NavigationView {
            ZStack {
                Map(coordinateRegion: $viewModel.selectedRegion)
                    .frame(maxWidth: .infinity)
                    .frame(maxHeight: .infinity)
                VStack {
                    switch viewModel.rouletteStatus {
                    case .rolling:
                        Spacer()
                        LottieView(animationType: .oneTwoThree)
                            .frame(width: 100)
                        Spacer()
                    case .notRolling, .endRolling:
                        VStack(alignment: .leading, spacing: 5) {
                            if let selectedCountry = viewModel.selectedCountry {
                                HStack(spacing: 10) {
                                    AsyncImage(url: URL(string: selectedCountry.flagPng)) { image in
                                        image
                                            .resizable()
                                            .scaledToFit()
                                    } placeholder: {
                                        ProgressView()
                                    }
                                    .frame(width: 60)
                                    Text(selectedCountry.commonNameJa ?? selectedCountry.commonName)
                                        .font(.title)
                                }
                            } else {
                                Text("全部行ったね！すごい！🎉")
                                    .font(.title)
                            }
                        }
                        .padding()
                        .frame(maxWidth: .infinity)
                        .background(Color.white)
                        .cornerRadius(15)
                        .padding(.horizontal, 16)
                        .padding(.top, 16)
                    }
                    Spacer()
                    Button(action: {
                        viewModel.startRoulette()
                    }) {
                        Text("旅をする")
                            .font(.title)
                            .frame(width: 150, height: 150)
                            .imageScale(.large)
                            .background(Color.green)
                            .foregroundColor(.white)
                            .clipShape(Circle())
                            .shadow(color: .gray, radius: 3, x: 5, y: 5)
                    }
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
