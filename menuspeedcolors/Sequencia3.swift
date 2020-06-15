//
//  Sequencia3.swift
//  menuspeedcolors
//
//  Created by Rui Pereira on 13/06/2020.
//  Copyright © 2020 Patricio Sampaio. All rights reserved.
//

import SpriteKit

class Sequencia3 : SKScene
{
    override init(size: CGSize) {
        super.init(size: size)
        
        let background = SKSpriteNode(imageNamed: "seq3")
        backgroundColor = SKColor.white
        background.zPosition = 1
        background.position = CGPoint(x:size.width / 2,y:size.height/2)
        addChild(background)
        
        
        
        
        let seqs = SKAction.sequence([
            SKAction.wait(forDuration: 3.0),
            SKAction.run() {
                let reveal = SKTransition.flipHorizontal(withDuration: 1.0)
                let scene = Gameplay(size: size)
                self.view?.presentScene(scene, transition: reveal)
            }
            ])
        run(seqs)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
