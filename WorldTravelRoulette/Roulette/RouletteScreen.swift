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
    @State var region = MKCoordinateRegion(
        center: CLLocationCoordinate2D(
            latitude: 35.68,
            longitude: 139.75
        ),
        latitudinalMeters: 1000 * 1000,
        longitudinalMeters: 1000 * 1000
    )

    var body: some View {

        NavigationView {
            VStack(spacing: 20) {
                switch viewModel.rouletteStatus {
                case .rolling:
                    Spacer()
                    LottieView(animationType: .oneTwoThree)
                        .frame(width: 100)
                case .notRolling, .endRolling:
                    VStack(alignment: .center, spacing: 5) {
                        if let selectedCountry = viewModel.selectedCountry {
                            HStack(spacing: 10) {
                                Text(selectedCountry.commonNameJa ?? selectedCountry.commonName)
                                    .font(.title)
                                AsyncImage(url: URL(string: selectedCountry.flagPng)) { image in
                                    image
                                        .resizable()
                                        .scaledToFit()
                                } placeholder: {
                                    ProgressView()
                                }
                                .frame(width: 60)
                            }
                            Text("\nにいこう！")
                                .font(.title2)
                            Map(coordinateRegion: $region)
                        } else {
                            Text("全部行ったね！すごい！🎉")
                                .font(.title)
                        }
                    }
                    .frame(maxWidth: .infinity)
                    .frame(maxHeight: .infinity)
                    .border(Color.red)
                }
                Spacer()
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
