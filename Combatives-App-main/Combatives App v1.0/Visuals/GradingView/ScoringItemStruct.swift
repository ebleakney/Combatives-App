//
//  ScoringItemStruct.swift
//  Combatives App v1.0
//
//  Created by James Huber on 4/3/24.
//

import SwiftUI

struct ScoringItem: Identifiable {
    let id = UUID()
    var description: String
    var points: Int
    var isExtraPoints: Bool
    var isSelected: Bool = false
}
