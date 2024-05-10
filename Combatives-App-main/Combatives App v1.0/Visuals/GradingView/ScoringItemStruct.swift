//
// ScoringItemStruct.swift
//
//


import SwiftUI

struct ScoringItem: Identifiable {
    let id = UUID()
    var description: String
    var points: Int
    var isExtraPoints: Bool
    var isSelected: Bool = false
}

class GradeManager: ObservableObject {
    
    @Published var bluePlayerScore: Int = 0 // Total score for the blue player
    @Published var bluePlayerName: String = "" // Name of the blue player
    @Published var bluePlayerSkillLevel: Int = 0 // Skill level of the blue player
    @Published var bluePlayerGender: String = "" // Gender of the blue player
    @Published var bluePlayerWeight: Int = 0 // Weight of the blue player
    
    // New subjective grading properties
    @Published var bluePlayerDiscipline: Double = 0
    @Published var bluePlayerStamina: Double = 0
    
    @Published var greyPlayerScore: Int = 0 // Total score for the grey player
    @Published var greyPlayerName: String = "" // Name of the blue player
    @Published var greyPlayerSkillLevel: Int = 0 // Skill level of the blue player
    @Published var greyPlayerGender: String = "" // Gender of the blue player
    @Published var greyPlayerWeight: Int = 0 // Weight of the blue player
    
    // New subjective grading properties
    @Published var greyPlayerDiscipline: Double = 0
    @Published var greyPlayerStamina: Double = 0
    
    // Function to update scores for the blue player
    func updateBluePlayerScore(points: Int, isExtraPoints: Bool) {
        if isExtraPoints {
            bluePlayerScore += 10
        } else {
            bluePlayerScore += points
        }
    }
        
    // Function to update scores for the grey player
    func updateGreyPlayerScore(points: Int, isExtraPoints: Bool) {
        if isExtraPoints {
            greyPlayerScore += 10
        } else {
            greyPlayerScore += points
        }
    }
}
