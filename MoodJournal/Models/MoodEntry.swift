//
//  MoodEntry.swift
//  MoodJournal
//
//  Created by Akanxi on 2025-04-26.
//

import Foundation
import SwiftUI
//Represents one mood entry (date + mood + optional note).
struct MoodEntry: Identifiable, Codable,Equatable {
    let id: UUID
    let date: Date
    var mood: MoodType
    var note: String?
    
    init(id: UUID = UUID(), date: Date = Date(), mood: MoodType, note: String? = nil) {
        self.id = id
        self.date = date
        self.mood = mood
        self.note = note
    }
}

//Different moods user can select (Happy, Sad, etc.)
enum MoodType: String, Codable, CaseIterable {
    case happy = "Happy"
    case sad = "Sad"
    case angry = "Angry"
    case calm = "Calm"
    case stressed = "Stressed"
    
    //Each mood type shows emoji
    var emoji: String {
        switch self {
        case .happy: return "😀"
        case .sad: return "😢"
        case .angry: return "😡"
        case .calm: return "😌"
        case .stressed: return "😣"
        }
    }
    //Each mood type shows a different color
    var color: Color {
        switch self {
        case .happy: return .yellow
        case .sad: return .blue
        case .angry: return .red
        case .calm: return .green
        case .stressed: return .purple
        }
    }
    
    
    
    
    
}
