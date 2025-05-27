//
//  MoodJournalApp.swift
//  MoodJournal
//
//  Created by Akanxi on 2025-04-26.
//

import SwiftUI

@main
struct MoodJournalApp: App {
    @StateObject private var viewModel = MoodViewModel() // Create shared ViewModel
    var body: some Scene {
        WindowGroup {
            TabView {
                MoodSelectionView() //User selects today's mood
                    .environmentObject(viewModel) // Inject into MoodSelectionView
                    .tabItem {
                        Image(systemName: "plus.circle")
                        Text("Journal")
                    }
                
                MoodHistoryView() //User sees all previous moods
                    .environmentObject(viewModel) // Inject into MoodHistoryView
                    .tabItem {
                        Image(systemName: "clock")
                        Text("History")
                    }
            }
        }
    }
}
