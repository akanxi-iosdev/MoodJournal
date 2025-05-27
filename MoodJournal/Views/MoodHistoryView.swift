//
//  MoodHistoryView.swift
//  MoodJournal
//
//  Created by Akanxi on 2025-04-26.
//

import SwiftUI

struct MoodHistoryView: View {
    @EnvironmentObject var viewModel: MoodViewModel
    var body: some View {
        NavigationView {
            if viewModel.moodEntries.isEmpty {
                VStack(spacing: 20) {
                    Text("No moods yet!")
                        .font(.title2)
                        .fontWeight(.bold)
                    Text("Start tracking your daily moods 🎯")
                        .font(.subheadline)
                        .foregroundColor(.secondary)
                }
                .multilineTextAlignment(.center)
                .padding()
            } else {
                List {
                    ForEach(viewModel.moodEntries.sorted(by: { $0.date > $1.date })) { entry in
                        ZStack {
                            RoundedRectangle(cornerRadius: 12)
                            .fill(entry.mood.color.opacity(0.2))
                            
                            HStack(spacing: 20) {
                                Text(entry.mood.emoji)
                                .font(.system(size: 40))
                                
                                VStack(alignment: .leading, spacing: 5) {
                                    Text(entry.mood.rawValue)
                                        .font(.headline)
                                        .foregroundColor(entry.mood.color)
                                    
                                    if let note = entry.note {
                                        Text(note)
                                            .font(.subheadline)
                                            .foregroundColor(.secondary)
                                    }
                                    
                                    Text(formattedDate(entry.date))
                                        .font(.caption)
                                        .foregroundColor(.gray)
                                }
                            }
                            .padding() // padding inside the colored box
                        }
                        .listRowSeparator(.hidden)
                        .padding(.vertical, 4)
                        .listRowInsets(EdgeInsets())
                        .animation(.easeIn(duration: 0.3), value: viewModel.moodEntries)
                    }
                    .onDelete(perform: viewModel.deleteMood)
                }
                .scrollContentBackground(.hidden)
                .navigationTitle("Mood History")
                .toolbar {
                    EditButton()
                }
            }
        }
    }
    private func formattedDate(_ date: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "EEEE, MMM d, yyyy 'at' h:mm a"
        // Example: Saturday, Apr 26, 2025 at 3:45 PM
        return formatter.string(from: date)
    }
}

#Preview {
    MoodHistoryView()
}
