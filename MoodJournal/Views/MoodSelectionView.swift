//
//  MoodSelectionView.swift
//  MoodJournal
//
//  Created by Akanxi on 2025-04-26.
//

import SwiftUI

struct MoodSelectionView: View {
    @EnvironmentObject var viewModel: MoodViewModel
       @State private var selectedMood: MoodType? = nil
       @State private var noteText: String = ""
       @State private var showingSavedAlert = false
       
       var body: some View {
           NavigationView {
               VStack(spacing: 20) {
                   Text("How are you feeling today?")
                       .font(.title2)
                       .fontWeight(.bold)
                       .multilineTextAlignment(.center)
                       .padding(.top, 20)
                   
                   ScrollView(.horizontal, showsIndicators: false) {
                       HStack(spacing: 20) {
                           ForEach(MoodType.allCases, id: \.self) { mood in
                               VStack {
                                   Text(mood.emoji)
                                       .font(.system(size: 50))
                                       .padding()
                                       .background(selectedMood == mood ? mood.color.opacity(0.7) : Color.gray.opacity(0.2))
                                       .clipShape(Circle())
                                       .onTapGesture {
                                           selectedMood = mood
                                       }
                                   
                                   Text(mood.rawValue)
                                       .font(.caption)
                               }
                           }
                       }
                       .padding(.horizontal)
                   }
                   
                   TextField("Write something about your day (optional)", text: $noteText)
                       .textFieldStyle(RoundedBorderTextFieldStyle())
                       .padding(.horizontal)
                   
                   Button(action: {
                       if let mood = selectedMood {
                           viewModel.addMood(mood: mood, note: noteText.isEmpty ? nil : noteText)
                           selectedMood = nil
                           noteText = ""
                           showingSavedAlert = true
                           
                           DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                               showingSavedAlert = false
                           }
                       }
                   }) {
                       Text("Save Mood")
                           .font(.headline)
                           .foregroundColor(.white)
                           .frame(maxWidth: .infinity)
                           .padding()
                           .background(selectedMood == nil ? Color.gray : Color.blue)
                           .cornerRadius(10)
                           .padding(.horizontal)
                   }
                .disabled(selectedMood == nil)
                   Spacer()
               }
               .overlay(
                   Group {
                       if showingSavedAlert {
                           Text("✅ Mood Saved!")
                               .font(.headline)
                               .padding()
                               .background(Color.green.opacity(0.85))
                               .cornerRadius(10)
                               .foregroundColor(.white)
                               .padding(.bottom, 40)
                               .transition(.move(edge: .bottom).combined(with: .opacity))
                               .animation(.easeInOut(duration: 0.3), value: showingSavedAlert)
                       }
                   },
                   alignment: .bottom
               )
               .navigationTitle("Mood Journal")
           }
       }
}

#Preview {
    MoodSelectionView()
}
