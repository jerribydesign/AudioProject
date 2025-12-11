//
//  SoundButton.swift
//  Audio Project
//
//  Created by Jericho Sanchez on 9/23/25.
//

import SwiftUI
import UIKit

struct SoundButton: View {
    // MARK: - Properties
    let clip: AudioClip
    let isLooping: Bool
    let onTap: () -> Void
    let onLongPress: () -> Void
    let onDoubleTap: () -> Void
    
    @State private var isPressed: Bool = false
    
    // MARK: - Haptic Feedback
    private func triggerHaptic(_ style: UIImpactFeedbackGenerator.FeedbackStyle) {
        let generator = UIImpactFeedbackGenerator(style: style)
        generator.prepare()
        generator.impactOccurred()
    }
    
    // MARK: - Computed Properties
    private var baseColor: Color {
        // Background track gets a distinct color
        if clip.fileName == "background" { return Color.purple }
        return isLooping ? Color.orange : Color.accentColor
    }
    
    private var backgroundColor: Color {
        isPressed ? baseColor.opacity(0.65) : baseColor
    }
    
    // MARK: - Body
    var body: some View {
        Button(action: {
            triggerHaptic(.light)
            onTap()
        }) {
            VStack(spacing: 8) {
                Text(clip.title)
                    .font(.headline)
                    .multilineTextAlignment(.center)
                    .foregroundColor(.white)
                
                Text(isLooping ? "Looping" : "One-shot")
                    .font(.caption)
                    .foregroundColor(.white.opacity(0.9))
            }
            .frame(maxWidth: .infinity)
            .padding(12)
            .background(
                RoundedRectangle(cornerRadius: AudioConfig.buttonCornerRadius)
                    .fill(backgroundColor)
            )
            .overlay(
                RoundedRectangle(cornerRadius: AudioConfig.buttonCornerRadius)
                    .stroke(Color.white.opacity(0.25), lineWidth: 1)
            )
            .shadow(color: Color.black.opacity(0.25), radius: 8, x: 0, y: 6)
            .contentShape(RoundedRectangle(cornerRadius: AudioConfig.buttonCornerRadius))
            .aspectRatio(1, contentMode: .fit)
        }
        .simultaneousGesture(
            LongPressGesture(minimumDuration: AudioConfig.longPressDuration)
                .onEnded { _ in
                    triggerHaptic(.medium)
                    onLongPress()
                }
        )
        .simultaneousGesture(
            TapGesture(count: 2)
                .onEnded {
                    triggerHaptic(.heavy)
                    onDoubleTap()
                }
        )
        .buttonStyle(.plain)
        .scaleEffect(isPressed ? AudioConfig.buttonPressScale : 1.0)
        .animation(
            .spring(
                response: AudioConfig.animationResponse,
                dampingFraction: AudioConfig.animationDamping
            ),
            value: isPressed
        )
        .gesture(
            DragGesture(minimumDistance: 0)
                .onChanged { _ in 
                    if !isPressed { 
                        isPressed = true 
                    } 
                }
                .onEnded { _ in 
                    isPressed = false 
                }
        )
        .accessibilityLabel(Text(clip.title))
        .accessibilityHint(
            Text(isLooping ? 
                "Looping. Double-tap to stop." : 
                "Tap to play. Long-press to loop."
            )
        )
    }
}

// MARK: - Preview
#Preview {
    let sampleClip = AudioClip(title: "Work it", fileName: "workit")
    
    return SoundButton(
        clip: sampleClip,
        isLooping: false,
        onTap: { print("Tapped") },
        onLongPress: { print("Long pressed") },
        onDoubleTap: { print("Double tapped") }
    )
    .padding()
}
