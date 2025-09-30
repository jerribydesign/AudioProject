//
//  AudioClip.swift
//  Audio Project
//
//  Created by Jericho Sanchez on 9/23/25.
//

import Foundation

struct AudioClip: Identifiable, Hashable {
    let id = UUID()
    let title: String
    let fileName: String
    let fileExtension: String
    let category: String?
    
    init(title: String, fileName: String, fileExtension: String = "m4a", category: String? = nil) {
        self.title = title
        self.fileName = fileName
        self.fileExtension = fileExtension
        self.category = category
    }
}
