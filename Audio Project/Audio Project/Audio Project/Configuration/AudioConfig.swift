//
//  AudioConfig.swift
//  Audio Project
//
//  Created by Jericho Sanchez on 9/23/25.
//

import Foundation

struct AudioConfig {
    // MARK: - File Settings
    static let audioFileExtension = "m4a"
    static let audioSubdirectory = "sounds"
    
    // MARK: - UI Settings
    static let gridColumns = 4
    static let buttonSpacing: CGFloat = 12
    static let buttonCornerRadius: CGFloat = 14
    static let buttonMinHeight: CGFloat = 84
    
    // MARK: - Audio Settings
    static let audioSessionCategory = "playback"
    static let audioSessionMode = "default"
    static let longPressDuration: Double = 0.5
    
    // MARK: - Animation Settings
    static let buttonPressScale: CGFloat = 0.98
    static let animationResponse: Double = 0.25
    static let animationDamping: Double = 0.8
}

// MARK: - Sample Data Configuration
extension AudioConfig {
    static let daftPunkSamples: [AudioClip] = [
        AudioClip(title: "Work it", fileName: "workit"),
        AudioClip(title: "Make it", fileName: "makeit"),
        AudioClip(title: "Do it", fileName: "doit"),
        AudioClip(title: "Makes us", fileName: "makesus"),
        AudioClip(title: "More than", fileName: "morethan"),
        AudioClip(title: "Hour", fileName: "hour"),
        AudioClip(title: "Never", fileName: "never"),
        AudioClip(title: "Ever", fileName: "ever"),
        AudioClip(title: "After", fileName: "after"),
        AudioClip(title: "Harder", fileName: "harder"),
        AudioClip(title: "Better", fileName: "better"),
        AudioClip(title: "Faster", fileName: "faster"),
        AudioClip(title: "Stronger", fileName: "stronger"),
        AudioClip(title: "Power", fileName: "power"),
        AudioClip(title: "Over", fileName: "over"),
        // Keep Background last so it appears bottom-right in a left-to-right, top-to-bottom grid
        AudioClip(title: "Background", fileName: "background")
    ]
    
    // Easy way to add your own samples
    static let customSamples: [AudioClip] = [
        // Add your own samples here
        // AudioClip(title: "My Sample", fileName: "mysample", category: "Custom"),
    ]
    
    // Combine all samples
    static var allSamples: [AudioClip] {
        return daftPunkSamples + customSamples
    }
}
