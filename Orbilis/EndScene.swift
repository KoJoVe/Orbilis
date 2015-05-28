//
//  EndScene.swift
//  Orbilis
//
//  Created by Joao Nassar Galante Guedes on 25/05/15.
//  Copyright (c) 2015 Joao Nassar Galante Guedes. All rights reserved.
//

import SpriteKit

class EndScene: SKScene {
    
    var gameOverOrb: SKSpriteNode = SKSpriteNode()
    var gameOver: SKLabelNode = SKLabelNode()
    var wellDone: SKLabelNode = SKLabelNode()
    var score: SKLabelNode = SKLabelNode()
    var congrats: SKLabelNode = SKLabelNode()
    var playAgain: SKLabelNode = SKLabelNode()
    var rateUs: SKLabelNode = SKLabelNode()
    
    var animationDuration = 0.5
    var scoreValue = 0
    
    override func didMoveToView(view: SKView) {
        /* Setup your scene here */
        
        //Oh noes! The environment collapsed!
        
        gameOver = SKLabelNode(text: "Oh no! The environment collapsed!")
        gameOver.position = CGPoint(x: self.frame.width/2, y: self.frame.height/1.15)
        gameOver.fontSize = 23
        self.addChild(gameOver)
        
        //Foto da orb
        
        gameOverOrb = SKSpriteNode(imageNamed: "RectGreen")
        gameOverOrb.position = CGPoint(x: self.frame.width/2, y: self.frame.height/1.4)
        gameOverOrb.size = CGSize(width: self.frame.width/3, height: self.frame.width/3)
        self.addChild(gameOverOrb)
        
        
        //But hey! Well done!
        
        wellDone = SKLabelNode(text: "But hey! Well done!")
        wellDone.position = CGPoint(x: self.frame.width/2, y: self.frame.height/1.9)
        wellDone.fontSize = 23
        self.addChild(wellDone)
        
        //You've kept up the orb for x days
        
        score = SKLabelNode(text: "You've kept up the orb for \(scoreValue) days!")
        score.position = CGPoint(x: self.frame.width/2, y: self.frame.height/2.2)
        score.fontSize = 23
        self.addChild(score)
        
        //Its a new record! (Ou nulo)
        
        if scoreValue >= UserData.getUserRecord() {
            
            congrats = SKLabelNode(text: "It's a new record!")
            congrats.position = CGPoint(x: self.frame.width/2, y: self.frame.height/2.7)
            congrats.fontSize = 23
            self.addChild(congrats)
            
            UserData.setUserRecord(scoreValue)
        }
        
        //Play again
        
        playAgain = SKLabelNode(text: "Play again")
        playAgain.position = CGPoint(x: self.frame.width/2, y: self.frame.height/4.5)
        playAgain.name = "playAgain"
        self.addChild(playAgain)
        
        //Rate us
        
        rateUs = SKLabelNode(text: "Rate us")
        rateUs.position = CGPoint(x: self.frame.width/2, y: self.frame.height*0.1)
        rateUs.name = "rateUs"
        self.addChild(rateUs)
        
    }
    
    override func touchesBegan(touches: Set<NSObject>, withEvent event: UIEvent) {
        /* Called when a touch begins */
        
        for touch in (touches as! Set<UITouch>) {
            
            var name = nodeAtPoint(touch.locationInNode(self)).name
            
            if name == "playAgain" {
                
                var fadeOut = SKAction.fadeOutWithDuration(animationDuration)
                var moveToCenter = SKAction.moveToY(self.frame.height/2 + 30, duration: animationDuration)
                var wait = SKAction.waitForDuration(animationDuration)
                var block = SKAction.runBlock({
                    
                    var transition = SKTransition.crossFadeWithDuration(self.animationDuration)
                    
                    var scene = StartScene(size:self.size)
                    
                    self.scene!.view?.presentScene(scene, transition: transition)
                    
                })
                var sequenceOrb = SKAction.sequence([wait,moveToCenter,block])
                
                self.gameOverOrb.runAction(sequenceOrb)
                self.gameOver.runAction(fadeOut)
                self.wellDone.runAction(fadeOut)
                self.score.runAction(fadeOut)
                self.congrats.runAction(fadeOut)
                self.playAgain.runAction(fadeOut)
                self.rateUs.runAction(fadeOut)
                
            }
            
        }
        
        
    }
    
    override func update(currentTime: CFTimeInterval) {
        /* Called before each frame is rendered */
    }
   
}
