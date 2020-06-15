//
//  Win.swift
//  menuspeedcolors
//
//  Created by Patricio Sampaio on 13/06/2020.
//  Copyright © 2020 Patricio Sampaio. All rights reserved.
//

import SpriteKit

class Win: SKScene {
    
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
        var time = PlayerStats.shared.getTime()
        var label = SKLabelNode(fontNamed: "Arial")
        label.fontSize = CGFloat.universalFont(size: 36)
        label.zPosition = 2
        label.color = SKColor.white
        label.horizontalAlignmentMode = .center
        label.verticalAlignmentMode = .center
        label.text = "Win in \(time) seconds"
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
        backButton.position = CGPoint(x: ScreenSize.width * -0.4, y: ScreenSize.heigth * 0.4)
        replayButton.position = CGPoint(x: ScreenSize.width * 0.0, y: ScreenSize.heigth * -0.10)
        
    }
    
    func addNodes(){
        addChild(background)
        addChild(title)
        addChild(backButton)
        addChild(replayButton)
    }
    
    
}
