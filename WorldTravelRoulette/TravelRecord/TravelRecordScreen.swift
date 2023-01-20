//
//  TravelRecordScreen.swift
//  WorldTravelRoulette
//
//  Created by mikaurakawa on 2023/01/19.
//

import SwiftUI

struct TravelRecordScreen: View {
    @ObservedObject var viewModel = TravelRecordViewModel()

    var body: some View {
        NavigationView {
            VStack {
                ScrollView {
                    VStack(alignment: .leading, spacing: 20) {
                        ForEach(viewModel.countries) { country in
                            CountryLabelView(
                                viewModel: viewModel,
                                country: country,
                                isButtonTapped: viewModel.isSavedCountry(country: country)
                            )
                                .padding(.horizontal, 16)
                        }
                    }
                }
            }
            .navigationTitle("どの国に行った？")
            .navigationBarTitleDisplayMode(.inline)
        }
        .onAppear {
            viewModel.onAppear()
        }
    }
}

struct TravelRecordScreen_Previews: PreviewProvider {
    static var previews: some View {
        TravelRecordScreen()
    }
}
