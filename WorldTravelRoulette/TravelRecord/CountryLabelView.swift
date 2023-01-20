//
//  CountryLabelView.swift
//  WorldTravelRoulette
//
//  Created by mikaurakawa on 2023/01/20.
//

import SwiftUI

struct CountryLabelView: View {
    @ObservedObject var viewModel: TravelRecordViewModel
    let country: Country
    @State var isButtonTapped: Bool

    var body: some View {
        HStack(alignment: .center, spacing: 20) {
            Button(action: {
                isButtonTapped.toggle()
                if isButtonTapped {
                    viewModel.didTapButton(buttonStatus: .selected, country: country)
                } else {
                    viewModel.didTapButton(buttonStatus: .notSelected, country: country)
                }
            }) {
                if isButtonTapped {
                    Image(systemName: "checkmark.circle.fill")
                        .resizable()
                        .scaledToFit()
                } else {
                    Image(systemName: "checkmark.circle")
                        .resizable()
                        .scaledToFit()
                }
            }
            .frame(width: 50, height: 50)
            Text(country.commonNameJa ?? country.commonName)
                .font(.title)
            Spacer()
            AsyncImage(url: URL(string: country.flagPng)) { image in
                image
                    .resizable()
                    .scaledToFit()
            } placeholder: {
                ProgressView()
            }
            .frame(width: 60)
        }
        .frame(maxWidth: .infinity)
    }
}

struct CountryLabelView_Previews: PreviewProvider {
    static var previews: some View {
        CountryLabelView(viewModel: TravelRecordViewModel(), country: Country(commonName: "DR Congo", commonNameJa: "コンゴ民主共和国", flagPng: "https://flagcdn.com/w320/zm.png", googleMapURL: "https://goo.gl/maps/mweBcqvW8TppZW6q9"), isButtonTapped: true)
    }
}
