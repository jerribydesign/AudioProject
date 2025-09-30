//
//  SoundVerification.swift
//  Audio Project
//
//  Created by Jericho Sanchez on 9/23/25.
//

import Foundation

struct SoundVerification {
    static func verifyAllSounds() {
        print("🔍 Verifying all sound files...")
        print("📁 Looking in subdirectory: \(AudioConfig.audioSubdirectory)")
        print("📄 File extension: \(AudioConfig.audioFileExtension)")
        print("")
        
        var missingFiles: [String] = []
        var foundFiles: [String] = []
        
        for clip in AudioConfig.allSamples {
            let fileName = "\(clip.fileName).\(clip.fileExtension)"
            let subdirectory = AudioConfig.audioSubdirectory
            
            if let url = Bundle.main.url(forResource: clip.fileName, withExtension: clip.fileExtension, subdirectory: subdirectory) {
                foundFiles.append(fileName)
                print("✅ Found: \(fileName)")
            } else {
                missingFiles.append(fileName)
                print("❌ Missing: \(fileName)")
            }
        }
        
        print("")
        print("📊 Summary:")
        print("✅ Found: \(foundFiles.count) files")
        print("❌ Missing: \(missingFiles.count) files")
        
        if missingFiles.isEmpty {
            print("🎉 All sound files are properly included!")
        } else {
            print("⚠️  Missing files:")
            for file in missingFiles {
                print("   - \(file)")
            }
            print("")
            print("💡 Make sure to add the sounds folder to your Xcode project:")
            print("   1. Right-click project → Add Files to 'Audio Project'")
            print("   2. Select the 'sounds' folder")
            print("   3. Choose 'Create folder references'")
            print("   4. Make sure 'Add to target: Audio Project' is checked")
        }
    }
    
    static func listAllConfiguredSounds() {
        print("🎵 Configured sounds in AudioConfig:")
        print("")
        
        for (index, clip) in AudioConfig.allSamples.enumerated() {
            let fileName = "\(clip.fileName).\(clip.fileExtension)"
            print("\(index + 1). \(clip.title) → \(fileName)")
        }
    }
}
