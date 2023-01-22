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
            Group {
                switch viewModel.retreiveStatus {
                case .empty:
                    Text("空です。")
                case .loading:
                    LottieView(animationType: .loading)
                case .success:
                    ScrollView {
                        LazyVStack(alignment: .leading, spacing: 20) {
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
                case .failure:
                    VStack {
                        Image(systemName: "exclamationmark.triangle.fill")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 80, height: 80)
                            .foregroundColor(.orange)
                        Text("エラーが発生しました")
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
