//
//  GameOver.swift
//  menuspeedcolors
//
//  Created by Patricio Sampaio on 12/06/2020.
//  Copyright © 2020 Patricio Sampaio. All rights reserved.
//

import Foundation
import SpriteKit

let kBackgroundMusicName = "BackgroundMusic"
let kBackgroundMusicExtension = "mp3"
let kSoundState = "kSoundState"
let kScore = "kScore"
let kBestScore = "kBestScore"
let kMusicVolume = "kMusicVolume"
let kTime = "kTime"
let kBestTime = "kBestTime"


enum SoundFileName: String {
  case TapFile = "tap.mp3"
}

class PlayerStats {
  
  private init() {}
  static let shared = PlayerStats()
  
  func setScore(_ value: Int) {
    
    if value > getBestScore() {
      setBestScore(value)
    }
    
    UserDefaults.standard.set(value, forKey: kScore)
    UserDefaults.standard.synchronize()
  }
  
  func getScore() -> Int {
    return UserDefaults.standard.integer(forKey: kScore)
  }
  
  func setBestScore(_ value: Int) {
    UserDefaults.standard.set(value, forKey: kBestScore)
    UserDefaults.standard.synchronize()
  }
  
  func getBestScore() -> Int {
    return UserDefaults.standard.integer(forKey: kBestScore)
  }
  
    func setTime(_ value: Int){
        if value < getBestTime() && value != 0 {
            setBestTime(value)
        }
        
        UserDefaults.standard.set(value, forKey: kTime)
        UserDefaults.standard.synchronize()
    }
    
    func setTimeAux(_ value: Int){
        UserDefaults.standard.set(value, forKey: kTime)
        UserDefaults.standard.synchronize()
    }
    
    func getTime() -> Int {
        return UserDefaults.standard.integer(forKey: kTime)
    }
    
    
    func setBestTime(_ value: Int) {
      UserDefaults.standard.set(value, forKey: kBestTime)
      UserDefaults.standard.synchronize()
    }
    
    func getBestTime() -> Int {
        return UserDefaults.standard.integer(forKey: kBestTime)
    }
    
  func setSounds(_ state: Bool) {
    UserDefaults.standard.set(state, forKey: kSoundState)
    UserDefaults.standard.synchronize()
  }
  
  func getSound() -> Bool {
    return UserDefaults.standard.bool(forKey: kSoundState)
  }
  
  func saveMusicVolume(_ value: Float) {
    UserDefaults.standard.set(value, forKey: kMusicVolume)
    UserDefaults.standard.synchronize()
  }
  
  func getMusicVolume() -> Float {
    return UserDefaults.standard.float(forKey: kMusicVolume)
  }
  
}







