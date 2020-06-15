//
//  Gameplay.swift
//  menuspeedcolors
//
//  Created by Patricio Sampaio on 12/06/2020.
//  Copyright © 2020 Patricio Sampaio. All rights reserved.
//

import SpriteKit

var BlueBall = SKSpriteNode()
var RedBall = SKSpriteNode()
var BlackBall = SKSpriteNode()
var nivel1 : Bool = false
var nivel2 : Bool = false
var nivel3 : Bool = false
var mostraseq1 : Bool = true
var mostraseq2 : Bool = false
var mostraseq3 : Bool = false

struct PhysicsCategory {
    
    static let none : UInt32 = 0 // 0
    static let bola1 : UInt32 = 0b1 // 1
    static let bola2 : UInt32 = 0b10 // 2
    static let bola3 : UInt32 = 0b11 // 3
    
}
class Gameplay: SKScene , SKPhysicsContactDelegate {
    
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
    
    var sec = PlayerStats.shared.getTime()
    var score = 0
    var streak = 0
    var vidas = 2
    
    lazy var scoreLabel:SKLabelNode = {
        var label = SKLabelNode(fontNamed: "Arial")
        label.fontSize = CGFloat.universalFont(size: 36)
        label.zPosition = 10
        label.color = SKColor.white
        label.horizontalAlignmentMode = .center
        label.verticalAlignmentMode = .center
        label.text = "\(score)"
        return label
    }()
    
    lazy var vidasLabel:SKLabelNode = {
        var label = SKLabelNode(fontNamed: "Arial")
        label.fontSize = CGFloat.universalFont(size: 25)
        label.zPosition = 10
        label.color = SKColor.white
        label.horizontalAlignmentMode = .center
        label.verticalAlignmentMode = .center
        label.text = "Lifes: \(vidas)"
        return label
    }()
    
    lazy var timeLabel:SKLabelNode = {
        var label = SKLabelNode(fontNamed: "Arial")
        label.fontSize = CGFloat.universalFont(size: 25)
        label.zPosition = 10
        label.color = SKColor.white
        label.horizontalAlignmentMode = .center
        label.verticalAlignmentMode = .center
        label.text = "Tempo(s): \(sec)"
        return label
    }()
    override func didMove(to view: SKView){
        
        if mostraseq1 == true
        {
            let reveal = SKTransition.doorsCloseHorizontal(withDuration: 3)
            let seq1 = Sequencia1(size: self.size)
            view.presentScene(seq1, transition: reveal)
            nivel1 = true
            mostraseq1 = false
        }
        
        if nivel1 == true
        {
            score = 0
        }
        else if nivel2 == true {
            score = 3
        }
        else if nivel3 == true {
            score = 7
        }
        physicsWorld.gravity = .zero
        physicsWorld.contactDelegate = self
        
        setupNodes()
        addNodes()
        run(SKAction.repeatForever(
        SKAction.sequence([
            SKAction.run(setupRedSpheres), SKAction.wait(forDuration: 1),
            SKAction.run(setupBlueSpheres), SKAction.wait(forDuration: 1),
            SKAction.run(setupBlackSpheres), SKAction.wait(forDuration: 1)
        ])))
    }
    
    func setupNodes(){
        background.position = CGPoint(x: ScreenSize.width * 0.5, y: ScreenSize.heigth * 0.5)
        scoreLabel.position = CGPoint(x: ScreenSize.width * 0.5, y: ScreenSize.heigth * 0.9)
        vidasLabel.position = CGPoint(x: ScreenSize.width * 0.10, y: ScreenSize.heigth * 0.9)
        timeLabel.position = CGPoint(x: ScreenSize.width * 0.80, y: ScreenSize.heigth * 0.9)
    }
    
    func addNodes(){
        addChild(background)
        addChild(scoreLabel)
        addChild(vidasLabel)
        addChild(timeLabel)
    }
    
    func setupBlueSpheres(){
        
        BlueBall = SKSpriteNode(imageNamed:"blue")
        let randomY = CGFloat.random(in: BlueBall.size.height ... size.height - BlueBall.size.height)
        
        BlueBall.position = CGPoint(x: size.width - BlueBall.size.width,
                                   y: randomY)
        BlueBall.physicsBody = SKPhysicsBody(rectangleOf: BlueBall.size)
        BlueBall.physicsBody?.isDynamic = true
        BlueBall.physicsBody?.categoryBitMask = PhysicsCategory.bola1
        BlueBall.physicsBody?.collisionBitMask = PhysicsCategory.none
        
        addChild(BlueBall)
        
        let toPoint = CGPoint(x: -BlueBall.size.width, y: randomY)
        let actionMove = SKAction.move(to: toPoint, duration: 3)
        let actionRemove = SKAction.removeFromParent()
        BlueBall.zPosition = 12
        BlueBall.run(SKAction.sequence([actionMove, actionRemove]))
        sec += 1
        scoreLabelUpdate()
    }
    func setupRedSpheres(){
        
        RedBall = SKSpriteNode(imageNamed:"red")
        let randomY = CGFloat.random(in: RedBall.size.height ... size.height - RedBall.size.height)
        
        RedBall.position = CGPoint(x: size.width - RedBall.size.width,
                                   y: randomY)
        RedBall.physicsBody = SKPhysicsBody(rectangleOf: RedBall.size)
        RedBall.physicsBody?.isDynamic = true
        RedBall.physicsBody?.categoryBitMask = PhysicsCategory.bola2
        RedBall.physicsBody?.collisionBitMask = PhysicsCategory.none
        
        addChild(RedBall)
        
        let toPoint = CGPoint(x: -RedBall.size.width, y: randomY)
        let actionMove = SKAction.move(to: toPoint, duration: 3)
        let actionRemove = SKAction.removeFromParent()
        RedBall.zPosition = 12
        RedBall.run(SKAction.sequence([actionMove, actionRemove]))
        sec += 1
        scoreLabelUpdate()
    }
    func setupBlackSpheres(){
        
        BlackBall = SKSpriteNode(imageNamed:"black")
        let randomY = CGFloat.random(in: BlackBall.size.height ... size.height - BlackBall.size.height)
        
        BlackBall.position = CGPoint(x: size.width - BlackBall.size.width,
                                   y: randomY)
        BlackBall.physicsBody = SKPhysicsBody(rectangleOf: BlackBall.size)
        BlackBall.physicsBody?.isDynamic = true
        BlackBall.physicsBody?.categoryBitMask = PhysicsCategory.bola3
        BlackBall.physicsBody?.collisionBitMask = PhysicsCategory.none
        
        addChild(BlackBall)
        
        let toPoint = CGPoint(x: -BlackBall.size.width, y: randomY)
        let actionMove = SKAction.move(to: toPoint, duration: 3)
        let actionRemove = SKAction.removeFromParent()
        BlackBall.zPosition = 12
        BlackBall.run(SKAction.sequence([actionMove, actionRemove]))
        sec += 1
        scoreLabelUpdate()
    }
    func scoreUpdate(){
        score += 1
        streak += 1
        scoreLabelUpdate()
    }
    
    func scoreLabelUpdate(){
        scoreLabel.text = "\(score)"
        vidasLabel.text = "Lifes: \(vidas)"
        timeLabel.text = "Tempo(s): \(sec)"
        
    }
    
    func wrongColor(){
        PlayerStats.shared.setTimeAux(sec)
        PlayerStats.shared.setScore(score)
        Manager.shared.transition(self, toScene: .GameOver, transition:
            SKTransition.moveIn(with: .right, duration: 0.5))
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
    for touch in touches{
    let location : CGPoint = touch.location(in: self)
        //print(nivel1)
        //print(nivel2)
        //print(nivel3)
    if nivel1 == true
        {
            if BlackBall.contains(location) && score == 0
            {
                BlackBall.removeFromParent()
                score += 1
                scoreLabelUpdate()
            }
            else if BlackBall.contains(location) && score != 0
            {
                print("errou")
                BlackBall.removeFromParent()
                vidas -= 1
                scoreLabelUpdate()
            }
            else if RedBall.contains(location) && score == 1
            {
                RedBall.removeFromParent()
                score += 1
                scoreLabelUpdate()
            }
            else if RedBall.contains(location) && score != 1
            {
                RedBall.removeFromParent()
                vidas -= 1
                scoreLabelUpdate()
            }
            else if BlueBall.contains(location) && score != 2
            {
                BlueBall.removeFromParent()
                vidas -= 1
                scoreLabelUpdate()
            }
            else if BlueBall.contains(location) && score == 2
            {
                BlueBall.removeFromParent()
                score += 1
                scoreLabelUpdate()
                if score == 3
                {
                        PlayerStats.shared.setTimeAux(sec)
                        let reveal = SKTransition.doorsCloseHorizontal(withDuration: 3)
                        let seq2 = Sequencia2(size: self.size)
                        view?.presentScene(seq2, transition: reveal)
                        //score = 0
                        vidas = 2
                        scoreLabelUpdate()
                        nivel2 = true
                        nivel1 = false
                }
            }
        }
        else if nivel2 == true
        {
            if BlueBall.contains(location) && score == 3
            {
                BlueBall.removeFromParent()
                score += 1
                scoreLabelUpdate()
            }
            else if BlueBall.contains(location) && score != 3
            {
                BlueBall.removeFromParent()
                vidas -= 1
                scoreLabelUpdate()
            }
            else if RedBall.contains(location) && score == 5
            {
                RedBall.removeFromParent()
                score += 1
                scoreLabelUpdate()
            }
            else if RedBall.contains(location) && score != 5
            {
                RedBall.removeFromParent()
                vidas -= 1
                scoreLabelUpdate()
            }
            else if BlackBall.contains(location) && score == 4
            {
                BlackBall.removeFromParent()
                score += 1
                scoreLabelUpdate()
            }
            else if BlackBall.contains(location) && score != 4 && score != 6
            {
                BlackBall.removeFromParent()
                vidas -= 1
                scoreLabelUpdate()
            }
            else if BlackBall.contains(location) && score == 6
            {
                BlackBall.removeFromParent()
                score += 1
                scoreLabelUpdate()
                if score == 7
                {
                        PlayerStats.shared.setTimeAux(sec)
                        let reveal = SKTransition.doorsCloseHorizontal(withDuration: 3)
                        let seq3 = Sequencia3(size: self.size)
                        view?.presentScene(seq3, transition: reveal)
                        //score = 0
                        vidas = 2
                        scoreLabelUpdate()
                        nivel3 = true
                        nivel2 = false
                }
                
            }
        }
        else if nivel3 == true
        {
            if BlackBall.contains(location) && score == 7
            {
                BlackBall.removeFromParent()
                score += 1
                scoreLabelUpdate()
            }
            else if BlueBall.contains(location) && score == 8 || BlueBall.contains(location) && score == 10
            {
                BlueBall.removeFromParent()
                score += 1
                scoreLabelUpdate()
            }
            else if BlueBall.contains(location) && score != 8 && score != 10
            {
                BlueBall.removeFromParent()
                vidas -= 1
                scoreLabelUpdate()
            }
            else if RedBall.contains(location) && score == 9
            {
                RedBall.removeFromParent()
                score += 1
                scoreLabelUpdate()
            }
            else if RedBall.contains(location) && score != 9
            {
                RedBall.removeFromParent()
                vidas -= 1
                scoreLabelUpdate()
            }
            else if BlackBall.contains(location) && score != 7 && score != 11
            {
                BlackBall.removeFromParent()
                vidas -= 1
                scoreLabelUpdate()
            }
            else if BlackBall.contains(location) && score == 11
            {
                BlackBall.removeFromParent()
                score += 1
                scoreLabelUpdate()
                PlayerStats.shared.setTime(sec)
                Manager.shared.transition(self, toScene: .Win, transition:
                SKTransition.moveIn(with: .right, duration: 0.5))
                nivel1 = true
                nivel2 = false
                nivel3 = false
                mostraseq1 = true
                //sec = 0
                
            }
        }
        if vidas <= 0 {
            
            nivel1 = true
            nivel2 = false
            nivel3 = false
            mostraseq1 = true
            //sec = 0
            wrongColor()
        }
    }
    }
    
    
}
