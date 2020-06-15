//
//  GameOver.swift
//  menuspeedcolors
//
//  Created by Patricio Sampaio on 12/06/2020.
//  Copyright © 2020 Patricio Sampaio. All rights reserved.
//

import SpriteKit

class GameOver: SKScene {
    
    var background: SKSpriteNode = {
        var sprite = SKSpriteNode(imageNamed: "BackGround")
        if DeviceType.isiPad || DeviceType.isiPadPro{
            sprite.scaleTo(screenWidthPercentage: 1.0)
        } else {
            sprite.scaleTo(screenHeightPercentage: 1.0)
        }
        sprite.zPosition = 0
        return sprite
    }()
    
    var title:SKLabelNode = {
        var label = SKLabelNode(fontNamed: "Arial")
        label.fontSize = CGFloat.universalFont(size: 36)
        label.zPosition = 2
        label.color = SKColor.white
        label.horizontalAlignmentMode = .center
        label.verticalAlignmentMode = .center
        label.text = "Game Over"
        return label
    }()
    
    var score:SKLabelNode = {
        var label = SKLabelNode(fontNamed: "Arial")
        label.fontSize = CGFloat.universalFont(size: 24)
        label.zPosition = 2
        label.color = SKColor.white
        label.horizontalAlignmentMode = .center
        label.verticalAlignmentMode = .center
        label.text = "Time: \(PlayerStats.shared.getTime())"
        return label
    }()
    
    var bestScore:SKLabelNode = {
        var label = SKLabelNode(fontNamed: "Arial")
        label.fontSize = CGFloat.universalFont(size: 24)
        label.zPosition = 2
        label.color = SKColor.white
        label.horizontalAlignmentMode = .center
        label.verticalAlignmentMode = .center
        label.text = "Best Time: \(PlayerStats.shared.getBestTime())"
        return label
    }()
    
    lazy var backButton: BDButton = {
        var button = BDButton(imageNamed: "backButton", buttonAction: {
            PlayerStats.shared.setTime(0)
            Manager.shared.transition(self, toScene: .MainMenu, transition:
                SKTransition.moveIn(with: .left, duration: 0.5))
        })
        button.zPosition = 1
        button.scaleTo(screenWithPercentage: 0.10)
        return button
    }()
    
    lazy var replayButton: BDButton = {
        var button = BDButton(imageNamed: "replayButton", buttonAction: {
            PlayerStats.shared.setTime(0)
            Manager.shared.transition(self, toScene: .Gameplay, transition:
                           SKTransition.moveIn(with: .left, duration: 0.5))
        })
        button.scaleTo(screenWithPercentage: 0.15)
        button.zPosition = 1
        return button
    }()
    
    override func didMove(to view: SKView){
        anchorPoint = CGPoint(x: 0.5, y: 0.5)
        setupNodes()
        addNodes()
        
    }
    
    func setupNodes(){
        background.position = CGPoint.zero
        title.position = CGPoint(x: ScreenSize.width * 0.0, y: ScreenSize.heigth * 0.25)
        score.position = CGPoint(x: ScreenSize.width * 0.0, y: ScreenSize.heigth * 0.12)
        bestScore.position = CGPoint(x: ScreenSize.width * 0.0, y: ScreenSize.heigth * 0.00)
        backButton.position = CGPoint(x: ScreenSize.width * -0.4, y: ScreenSize.heigth * 0.4)
        replayButton.position = CGPoint(x: ScreenSize.width * 0.0, y: ScreenSize.heigth * -0.20)
        
    }
    
    func addNodes(){
        addChild(background)
        addChild(title)
        addChild(score)
        addChild(bestScore)
        addChild(backButton)
        addChild(replayButton)
    }
}
