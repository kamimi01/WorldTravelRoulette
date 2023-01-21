//
//  Array+Extension.swift
//  WorldTravelRoulette
//
//  Created by mikaurakawa on 2023/01/22.
//

import Foundation

extension Array {
    subscript (safe index: Index) -> Element? {
        if indices.contains(index) {
            return self[index]
        }
        print("index out of range, so retrun nil")
        return nil
    }
}
