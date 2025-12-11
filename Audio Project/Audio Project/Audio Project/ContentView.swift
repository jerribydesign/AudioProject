//
//  ContentView.swift
//  Audio Project
//
//  Created by Jericho Sanchez on 9/23/25.
//

import SwiftUI

struct ContentView: View {
    // MARK: - Properties
    @StateObject private var audioManager = AudioManager()
    @State private var showOnboarding: Bool = false
    
    // MARK: - Initialization
    init() {
        // Check if onboarding has been shown before
        let hasSeenOnboarding = UserDefaults.standard.bool(forKey: "hasSeenOnboarding")
        _showOnboarding = State(initialValue: !hasSeenOnboarding)
    }
    
    // MARK: - Computed Properties
    private var gridColumns: [GridItem] {
        Array(repeating: GridItem(.flexible(), spacing: AudioConfig.buttonSpacing), 
              count: AudioConfig.gridColumns)
    }
    
    // MARK: - Body
    var body: some View {
        NavigationView {
            ScrollView {
                LazyVGrid(columns: gridColumns, spacing: AudioConfig.buttonSpacing) {
                    ForEach(AudioConfig.allSamples) { clip in
                        SoundButton(
                            clip: clip,
                            isLooping: audioManager.isLooping(for: clip),
                            onTap: { audioManager.play(clip) },
                            onLongPress: { audioManager.toggleLoop(for: clip) },
                            onDoubleTap: { audioManager.stopAll(for: clip) }
                        )
                    }
                }
                .padding(16)
            }
            .navigationTitle("Daft Punk Pad")
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    HStack {
                        Button("Debug Work It") {
                            let workItClip = AudioClip(title: "Work it", fileName: "workit")
                            audioManager.debugSpecificSound(workItClip)
                        }
                        Button("Test") {
                            audioManager.testAudioSystem()
                        }
                        Button("Stop All") {
                            audioManager.stopAllSounds()
                        }
                    }
                }
            }
        }
        .fullScreenCover(isPresented: $showOnboarding) {
            OnboardingView(isPresented: $showOnboarding)
        }
    }
}

#Preview {
    ContentView()
}
