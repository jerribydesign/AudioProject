//
//  AudioManager.swift
//  Audio Project
//
//  Created by Jericho Sanchez on 9/23/25.
//

import Foundation
import AVFoundation
import SwiftUI
import AudioToolbox

final class AudioManager: NSObject, ObservableObject {
    // MARK: - Published Properties
    @Published var isLoopingByName: [String: Bool] = [:]
    
    // MARK: - Private Properties
    private var activePlayersByName: [String: [AVAudioPlayer]] = [:]
    private let audioConfig = AudioConfig.self
    
    // MARK: - Initialization
    override init() {
        super.init()
        setupAudioSession()
    }
    
    // MARK: - Audio Session Setup
    private func setupAudioSession() {
        do {
            try AVAudioSession.sharedInstance().setCategory(
                .playback,
                mode: .default,
                options: [.mixWithOthers, .allowBluetooth, .allowBluetoothA2DP]
            )
            try AVAudioSession.sharedInstance().setActive(true)
            print("✅ Audio session configured successfully")
        } catch {
            print("❌ Audio session error: \(error)")
        }
    }
    
    // MARK: - Public Methods
    func play(_ clip: AudioClip) {
        // First try to find the file in Assets (where you added them)
        var url: URL?
        
        // Try Assets first
        if let assetURL = Bundle.main.url(forResource: clip.fileName, withExtension: clip.fileExtension) {
            url = assetURL
            print("🎵 Found in Assets: \(clip.fileName).\(clip.fileExtension)")
        }
        // Try subdirectory as fallback
        else if let subdirectoryURL = Bundle.main.url(
            forResource: clip.fileName,
            withExtension: clip.fileExtension,
            subdirectory: audioConfig.audioSubdirectory
        ) {
            url = subdirectoryURL
            print("🎵 Found in subdirectory: \(clip.fileName).\(clip.fileExtension)")
        }
        
        guard let finalURL = url else {
            print("❌ Missing sound: \(clip.fileName).\(clip.fileExtension)")
            print("💡 Make sure the file is added to your Xcode project (not just Assets)")
            return
        }
        
        print("🎵 Playing: \(clip.fileName).\(clip.fileExtension)")
        print("📁 URL: \(finalURL)")
        
        do {
            let player = try AVAudioPlayer(contentsOf: finalURL)
            player.prepareToPlay()
            player.numberOfLoops = (isLoopingByName[clip.fileName] ?? false) ? -1 : 0
            player.delegate = self
            player.volume = 1.0 // Ensure volume is at maximum
            activePlayersByName[clip.fileName, default: []].append(player)
            
            let success = player.play()
            if success {
                print("✅ Successfully started playing: \(clip.fileName)")
            } else {
                print("❌ Failed to start playback for: \(clip.fileName)")
            }
        } catch {
            print("❌ Failed to create player for \(clip.fileName): \(error)")
        }
    }
    
    func toggleLoop(for clip: AudioClip) {
        let newState = !(isLoopingByName[clip.fileName] ?? false)
        isLoopingByName[clip.fileName] = newState
        
        // Update currently active players for that clip
        activePlayersByName[clip.fileName]?.forEach { 
            $0.numberOfLoops = newState ? -1 : 0 
        }
    }
    
    func stopAll(for clip: AudioClip) {
        activePlayersByName[clip.fileName]?.forEach { $0.stop() }
        activePlayersByName[clip.fileName] = []
    }
    
    func stopAllSounds() {
        for (_, players) in activePlayersByName {
            players.forEach { $0.stop() }
        }
        activePlayersByName.removeAll()
    }
    
    func isLooping(for clip: AudioClip) -> Bool {
        return isLoopingByName[clip.fileName] ?? false
    }
    
    // MARK: - Debug Methods
    func testAudioSystem() {
        print("🔧 Testing audio system...")
        print("📱 Device volume: \(AVAudioSession.sharedInstance().outputVolume)")
        print("🔊 Audio session category: \(AVAudioSession.sharedInstance().category)")
        print("🎵 Audio session mode: \(AVAudioSession.sharedInstance().mode)")
        print("🔗 Audio session active: \(AVAudioSession.sharedInstance().isOtherAudioPlaying)")
        
        // Test with a simple system sound
        AudioServicesPlaySystemSound(1000) // This should play a system sound
        print("🔔 System sound test completed")
    }
    
    func debugSpecificSound(_ clip: AudioClip) {
        print("🔍 Debugging sound: \(clip.title)")
        print("📄 File name: \(clip.fileName)")
        print("📁 Extension: \(clip.fileExtension)")
        
        // Check Assets first
        let assetExists = Bundle.main.url(forResource: clip.fileName, withExtension: clip.fileExtension) != nil
        print("📋 File exists in Assets: \(assetExists)")
        
        // Check subdirectory
        let subdirectoryExists = Bundle.main.url(
            forResource: clip.fileName,
            withExtension: clip.fileExtension,
            subdirectory: audioConfig.audioSubdirectory
        ) != nil
        print("📋 File exists in subdirectory: \(subdirectoryExists)")
        
        // Try to get URL from Assets first
        if let assetURL = Bundle.main.url(forResource: clip.fileName, withExtension: clip.fileExtension) {
            print("✅ Found in Assets: \(assetURL)")
            print("📁 File path: \(assetURL.path)")
            
            // Check if file is readable
            do {
                let data = try Data(contentsOf: assetURL)
                print("📊 File size: \(data.count) bytes")
                print("✅ File is readable")
            } catch {
                print("❌ Cannot read file: \(error)")
            }
        }
        // Try subdirectory as fallback
        else if let subdirectoryURL = Bundle.main.url(
            forResource: clip.fileName,
            withExtension: clip.fileExtension,
            subdirectory: audioConfig.audioSubdirectory
        ) {
            print("✅ Found in subdirectory: \(subdirectoryURL)")
            print("📁 File path: \(subdirectoryURL.path)")
            
            // Check if file is readable
            do {
                let data = try Data(contentsOf: subdirectoryURL)
                print("📊 File size: \(data.count) bytes")
                print("✅ File is readable")
            } catch {
                print("❌ Cannot read file: \(error)")
            }
        } else {
            print("❌ File not found in either location")
            print("💡 Make sure the file is added to your Xcode project")
        }
    }
}

// MARK: - AVAudioPlayerDelegate
extension AudioManager: AVAudioPlayerDelegate {
    func audioPlayerDidFinishPlaying(_ player: AVAudioPlayer, successfully flag: Bool) {
        // Clean up finished players
        for (name, players) in activePlayersByName {
            if let idx = players.firstIndex(where: { $0 === player }) {
                activePlayersByName[name]?.remove(at: idx)
                break
            }
        }
    }
}
