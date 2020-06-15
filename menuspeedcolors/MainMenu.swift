//
//  MainMenu.swift
//  menuspeedcolors
//
//  Created by Patricio Sampaio on 12/06/2020.
//  Copyright © 2020 Patricio Sampaio. All rights reserved.
//

import SpriteKit

class MainMenu: SKScene{
    
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
        label.text = "SpeedColors"
        return label
    }()

    lazy var playButton: BDButton = {
        var button = BDButton(imageNamed: "ButtonPlay", buttonAction: {
            PlayerStats.shared.setTime(0)
            self.startGameplay()
        })
        button.scaleTo(screenWithPercentage: 0.15)
        button.zPosition = 1
        return button
    }()
    
    override func didMove(to view : SKView){
        
        anchorPoint = CGPoint(x: 0.5, y: 0.5)
        
        setupNodes()
        addNodes()
    }
    
    
    func setupNodes(){
        background.position = CGPoint.zero
        title.position = CGPoint(x: ScreenSize.width * 0.0, y: ScreenSize.heigth * 0.25)
        playButton.position = CGPoint.zero
        
    }
    
    func addNodes(){
        addChild(background)
        addChild(title)
        addChild(playButton)
    }
    
    @objc func startGameplayNotification(_ info:Notification){
        startGameplay()
    }
    
    func startGameplay(){
        Manager.shared.transition(self, toScene: .Gameplay, transition:
            SKTransition.moveIn(with: .right, duration: 0.5))
    }
    
    
}
