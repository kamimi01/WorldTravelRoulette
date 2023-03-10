//
//  CircularProgressbarView.swift
//  JapanTravelRoulette
//
//  Created by mikaurakawa on 2023/01/23.
//

import SwiftUI

struct CircularProgressbarView: View {
    @Binding var numOfCountries: Int
    let numOfAllCountries: Int

    var body: some View {
        ZStack {
            // 背景の円
            Circle()
            // ボーダーラインを描画するように指定
                .stroke(lineWidth: 15.0)
                .opacity(0.3)
                .foregroundColor(.green)

            // 進捗を示す円
            Circle()
            // 始点/終点を指定して円を描画する
            // 始点/終点には0.0-1.0の範囲に正規化した値を指定する
                .trim(from: 0.0, to: min(CGFloat(Double(numOfCountries) / Double(numOfAllCountries)), 1.0))
            // 線の端の形状などを指定
                .stroke(style: StrokeStyle(lineWidth: 15, lineCap: .round, lineJoin: .round))
                .foregroundColor(.green)
            // デフォルトの原点は時計の12時の位置ではないので回転させる
                .rotationEffect(Angle(degrees: 270.0))

            // 進捗率のテキスト
            HStack {
                Text(String(numOfCountries))
                    .foregroundColor(.green)
                    .font(.largeTitle)
                    .bold()
                Text("/\(numOfAllCountries)")
                    .font(.title2)
                    .foregroundColor(.gray)
            }
        }
    }
}

struct CircularProgressbarView_Previews: PreviewProvider {
    static var previews: some View {
        CircularProgressbarView(numOfCountries: .constant(100), numOfAllCountries: 200)
    }
}
