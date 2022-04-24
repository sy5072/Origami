//
//  File.swift
//  Origami
//
//  Created by Seungyun Kim on 2022/04/25.
//

import Foundation
import AVKit
import SwiftUI


class SoundManager: ObservableObject {
    
    static let instance = SoundManager()
    
    var player: AVAudioPlayer?
    
    enum soundOption: String {
        case CMajor
        case DMajor
        case EMajor
        case FMajor
        case GMajor
        case AMajor
        case BMajor
        case Duckquack
    }
    
    func playSound(sounds: soundOption) {
        guard let url = Bundle.main.url(forResource: sounds.rawValue, withExtension: ".m4a") else { return }
        
        do {
            player = try AVAudioPlayer(contentsOf: url)
            player?.play()
        } catch let error {
            print("재생하는데 오류가 생겼습니다. 오류코드 \(error.localizedDescription)")
        }
    }
    
}
