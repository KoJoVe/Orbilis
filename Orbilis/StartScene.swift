//
//  StartScene.swift
//  Orbilis
//
//  Created by Joao Nassar Galante Guedes on 25/05/15.
//  Copyright (c) 2015 Joao Nassar Galante Guedes. All rights reserved.
//

import SpriteKit

class StartScene: SKScene {
    
    var initialOrb: SKSpriteNode = SKSpriteNode()
    var orbTitle: SKLabelNode = SKLabelNode()
    var orbPlay: SKLabelNode = SKLabelNode()
    var orbTutorial: SKLabelNode = SKLabelNode()
    var animationDuration = 0.5
    
    override func didMoveToView(view: SKView) {
        /* Setup your scene here */
        
        //Orb no meio
        //Titulo orbilis
        //tap screen to play
        
        initialOrb = SKSpriteNode(imageNamed: "rectGreen")
        initialOrb.position = CGPointMake(self.frame.width/2, self.frame.height/2 + 30)
        initialOrb.size = CGSize(width: self.frame.width/3, height: self.frame.width/3)
        self.addChild(initialOrb)
        
        var labelPosition = CGPoint(x: initialOrb.position.x, y: initialOrb.position.y - initialOrb.size.height/1.25)
        
        orbTitle = SKLabelNode(text: "Orbilis")
        orbTitle.position = labelPosition
        self.addChild(orbTitle)
        
        labelPosition = CGPoint(x: labelPosition.x, y: labelPosition.y - initialOrb.size.height/1.25)
        
        orbPlay = SKLabelNode(text: "Tap to play!")
        orbPlay.position = labelPosition
        self.addChild(orbPlay)
        
        //tutorial
        
        labelPosition = CGPoint(x: labelPosition.x, y: labelPosition.y - initialOrb.size.height/1.25)
        
        orbTutorial = SKLabelNode(text: "Tutorial")
        orbTutorial.position = labelPosition
        orbTutorial.name = "tutorial"
        self.addChild(orbTutorial)
        
        
//        Check if First Time
        
        UserData.initializePlist()
        
        if UserData.isFirstTime() == 0 {
        
            UserData.setAlreadyUser(1)
            
        }

        println(UserData.isFirstTime())
        
    }
    
    override func touchesBegan(touches: Set<NSObject>, withEvent event: UIEvent) {
        /* Called when a touch begins */
        
        for touch in (touches as! Set<UITouch>) {
            
            var name = nodeAtPoint(touch.locationInNode(self)).name
            
            if name == "tutorial" {
                
                
            }
            
            else {
                
                var fadeOut = SKAction.fadeOutWithDuration(animationDuration)
                var moveToCenter = SKAction.moveToY(self.frame.height/2, duration: animationDuration)
                var increaseSize = SKAction.resizeByWidth(self.frame.width*2/3 - 40, height: self.frame.width*2/3-40, duration: animationDuration)
                var wait = SKAction.waitForDuration(animationDuration)
                var group = SKAction.group([moveToCenter,increaseSize])
                var block = SKAction.runBlock({
                    
                    var scene = GameScene(size:self.size)
                    
                    self.scene!.view?.presentScene(scene, transition: nil)
                    
                })
                var sequenceOrb = SKAction.sequence([wait,group,block])
                
                self.orbPlay.runAction(fadeOut)
                self.orbTitle.runAction(fadeOut)
                self.orbTutorial.runAction(fadeOut)
                self.initialOrb.runAction(sequenceOrb)
                
            }
            
        }
        
    }
    
    override func update(currentTime: CFTimeInterval) {
        /* Called before each frame is rendered */
    }
   
}
