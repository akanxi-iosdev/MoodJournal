//
//  MoodViewModel.swift
//  MoodJournal
//
//  Created by Akanxi on 2025-04-26.
//

import Foundation
class MoodViewModel: ObservableObject {
    
    @Published var moodEntries: [MoodEntry] = [] //Holds all moods user has added
    
    private let saveKey = "SavedMoods"
    
    init() {
        loadMoods()
    }
    //Adds a new mood for today
    func addMood(mood: MoodType, note: String?) {
        let newMood = MoodEntry(mood: mood, note: note)
        moodEntries.append(newMood)
        saveMoods()
    }
    
    //Saves moods to UserDefaults
    func saveMoods() {
        if let encoded = try? JSONEncoder().encode(moodEntries) {
            UserDefaults.standard.set(encoded, forKey: saveKey)
        }
    }
    
    //Loads moods when app starts
    func loadMoods() {
        if let savedData = UserDefaults.standard.data(forKey: saveKey),
           let decoded = try? JSONDecoder().decode([MoodEntry].self, from: savedData) {
            self.moodEntries = decoded
        }
    }
    
    //Deletes a mood entry if user wants to remove it
    func deleteMood(at offsets: IndexSet) {
        moodEntries.remove(atOffsets: offsets)
        saveMoods()
    }
}
