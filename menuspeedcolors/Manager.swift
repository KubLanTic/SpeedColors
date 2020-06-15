//
//  GameOver.swift
//  menuspeedcolors
//
//  Created by Patricio Sampaio on 12/06/2020.
//  Copyright © 2020 Patricio Sampaio. All rights reserved.
//

import Foundation
import SpriteKit

let AppId = "123456"
let chartboostAppID = "5a3cfaf8e6d7050d5c5c6dce"
let chartboostAppSignature = "97a43ed515d78826130881e8c0eed747185d0d74"

class Manager {
  
  enum SceneType {
    case MainMenu, Gameplay, GameOver, Win
  }
  
  private init() {}
  static let shared = Manager()
  
  public func launch() {
    firstLaunch()
  }
  
  private func firstLaunch() {
    if !UserDefaults.standard.bool(forKey: "isFirstLaunch") {
      
      print("This is our first launch")
      
      UserDefaults.standard.set(true, forKey: "isFirstLaunch")
      UserDefaults.standard.synchronize()
    }
  }
  
  func transition(_ fromScene: SKScene, toScene: SceneType, transition: SKTransition? = nil ) {
    guard let scene = getScene(toScene) else { return }
    
    if let transition = transition {
      scene.scaleMode = .resizeFill
      fromScene.view?.presentScene(scene, transition: transition)
    } else {
      scene.scaleMode = .resizeFill
      fromScene.view?.presentScene(scene)
    }
    
  }
  
  func getScene(_ sceneType: SceneType) -> SKScene? {
    switch sceneType {
    case SceneType.MainMenu:
      return MainMenu(size: CGSize(width: ScreenSize.width, height: ScreenSize.heigth))
    case SceneType.Gameplay:
      return Gameplay(size: CGSize(width: ScreenSize.width, height: ScreenSize.heigth))
    case SceneType.GameOver:
      return GameOver(size: CGSize(width: ScreenSize.width, height: ScreenSize.heigth))
    case SceneType.Win:
      return Win(size: CGSize(width: ScreenSize.width, height: ScreenSize.heigth))
    }
  }
  
  func run(_ fileName: String, onNode: SKNode) {
    if PlayerStats.shared.getSound() {
      onNode.run(SKAction.playSoundFileNamed(fileName, waitForCompletion: false))
    }
  }
}


































