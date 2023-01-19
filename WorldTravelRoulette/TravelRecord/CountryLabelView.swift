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
            Text(country.commonNameJa)
                .font(.title)
            Spacer()
        }
        .frame(maxWidth: .infinity)
    }
}

struct CountryLabelView_Previews: PreviewProvider {
    static var previews: some View {
        CountryLabelView(viewModel: TravelRecordViewModel(), country: Country(commonNameJa: "コンゴ民主共和国", flagPng: "https://flagcdn.com/w320/zm.png"), isButtonTapped: true)
    }
}
