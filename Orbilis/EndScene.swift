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
    var playButton = SKSpriteNode()
    var rateButton = SKSpriteNode()
    
    var animationDuration = 0.4
    var scoreValue = 0
    
    override func didMoveToView(view: SKView) {
        /* Setup your scene here */
        
        //Oh noes! The environment collapsed!
        
        var background = SKSpriteNode(imageNamed: "Background")
        background.size = CGSizeMake(self.frame.size.width, self.frame.size.height)
        background.position = CGPointMake(CGRectGetMidX(self.frame), CGRectGetMidY(self.frame))
        background.zPosition = -1
        background.name = "TheBackground"
        self.addChild(background)
        
        gameOver = SKLabelNode(text: "Oh no! The environment collapsed!")
        gameOver.position = CGPoint(x: self.frame.width/2, y: self.frame.height/1.15)
        gameOver.fontSize = 18
        gameOver.fontName = "Avenir-Roman"
        self.addChild(gameOver)
        
        //Foto da orb
        
        gameOverOrb = SKSpriteNode(imageNamed: "OrbFlood")
        gameOverOrb.position = CGPoint(x: self.frame.width/2, y: self.frame.height/1.4)
        gameOverOrb.size = CGSize(width: self.frame.width/3, height: self.frame.width/3)
        self.addChild(gameOverOrb)
        
        
        //But hey! Well done!
        
        wellDone = SKLabelNode(text: "But hey! Well done!")
        wellDone.position = CGPoint(x: self.frame.width/2, y: self.frame.height/1.9)
        wellDone.fontSize = 18
        wellDone.fontName = "Avenir-Roman"
        self.addChild(wellDone)
        
        //You've kept up the orb for x days
        
        score = SKLabelNode(text: "You've kept up the orb for \(scoreValue) days!")
        score.position = CGPoint(x: self.frame.width/2, y: self.frame.height/2.2)
        score.fontSize = 15
        score.fontName = "Avenir-Roman"
        self.addChild(score)
        
        //Its a new record! (Ou nulo)
        
      if scoreValue >= UserData.getUserRecord() {
//            
            congrats = SKLabelNode(text: "It's a new record!")
            congrats.position = CGPoint(x: self.frame.width/2, y: self.frame.height/2.7)
            congrats.fontSize = 23
            congrats.fontName = "Avenir-Roman"
            self.addChild(congrats)
//
            UserData.setUserRecord(scoreValue)
        }
    
        //Play again
        
        playButton = SKSpriteNode(imageNamed: "PlayButton")
        playButton.size = CGSizeMake(self.frame.width/7, self.frame.width/7)
        playButton.position = CGPoint(x: self.frame.width/2 - 65, y: self.frame.height/6.5 + playButton.size.height/2 + 30)
        playButton.name = "playAgain"
        self.addChild(playButton)
        
        playAgain = SKLabelNode(text: "Play again")
        playAgain.position = CGPoint(x: self.frame.width/2 - 65, y: self.frame.height/6.5)
        playAgain.name = "playAgain"
        playAgain.fontSize = 20
        playAgain.fontName = "Avenir-Roman"
        self.addChild(playAgain)
        
        //Rate us
        
        rateButton = SKSpriteNode(imageNamed: "RateButton")
        rateButton.size = CGSizeMake(self.frame.width/7, self.frame.width/7)
        rateButton.position = CGPoint(x: self.frame.width/2 + 70, y: self.frame.height/6.5 + rateButton.size.height/2 + 30)
        rateButton.name = "rateUs"
        self.addChild(rateButton)
        
        rateUs = SKLabelNode(text: "Rate us")
        rateUs.position = CGPoint(x: self.frame.width/2 + 70, y: self.frame.height/6.5)
        rateUs.name = "rateUs"
        rateUs.fontSize = 20
        rateUs.fontName = "Avenir-Roman"
        self.addChild(rateUs)
        
    }
    
    override func touchesBegan(touches: Set<NSObject>, withEvent event: UIEvent) {
        /* Called when a touch begins */
        
        for touch in (touches as! Set<UITouch>) {
            
            var name = nodeAtPoint(touch.locationInNode(self)).name
            
            if name == "playAgain" {
                
                var fadeOut = SKAction.fadeOutWithDuration(animationDuration)
                var moveToCenter = SKAction.moveToY(self.frame.height/2 + 30, duration: animationDuration)
                moveToCenter.timingMode = SKActionTimingMode.EaseInEaseOut
                var wait = SKAction.waitForDuration(animationDuration)
                var block = SKAction.runBlock({
                    
                    var transition = SKTransition.crossFadeWithDuration(self.animationDuration)
                    
                    var scene = StartScene(size:self.size)
                    
                    self.scene!.view?.presentScene(scene, transition: transition)
                    
                })
                var sequenceOrb = SKAction.sequence([wait,moveToCenter,block])
                sequenceOrb.timingMode = SKActionTimingMode.EaseInEaseOut
                
                self.gameOverOrb.runAction(sequenceOrb)
                self.gameOver.runAction(fadeOut)
                self.wellDone.runAction(fadeOut)
                self.score.runAction(fadeOut)
                self.congrats.runAction(fadeOut)
                self.playAgain.runAction(fadeOut)
                self.rateUs.runAction(fadeOut)
                self.playButton.runAction(fadeOut)
                self.rateButton.runAction(fadeOut)
                
            } else if name == "rateUs" {
                
                //Mudar ID
                var url = "itms-apps://itunes.apple.com/WebObjects/MZStore.woa/wa/viewContentsUserReviews?id=991654758&onlyLatestVersion=true&pageNumber=0&sortOrdering=1)"
                UIApplication.sharedApplication().openURL(NSURL(string: url)!)
                
            }
            
        }
        
        
    }
    
    override func update(currentTime: CFTimeInterval) {
        /* Called before each frame is rendered */
    }
   
}
