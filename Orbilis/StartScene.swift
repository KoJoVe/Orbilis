//
//  StartScene.swift
//  Orbilis
//
//  Created by Joao Nassar Galante Guedes on 25/05/15.
//  Copyright (c) 2015 Joao Nassar Galante Guedes. All rights reserved.
//

import SpriteKit
import UIKit

class StartScene: SKScene, UIAlertViewDelegate {
    
    var initialOrb: SKSpriteNode = SKSpriteNode()
    var orbTitle: SKLabelNode = SKLabelNode()
    var orbPlay: SKLabelNode = SKLabelNode()
    var orbTutorial: SKLabelNode = SKLabelNode()
    var animationDuration = 0.4
    
    override func didMoveToView(view: SKView) {
        /* Setup your scene here */
        
        //Orb no meio
        //Titulo orbilis
        //tap screen to play
        
        var background = SKSpriteNode(imageNamed: "Background")
        background.size = CGSizeMake(self.frame.size.width, self.frame.size.height)
        background.position = CGPointMake(CGRectGetMidX(self.frame), CGRectGetMidY(self.frame))
        background.zPosition = -1
        background.name = "TheBackground"
        self.addChild(background)
        
        initialOrb = SKSpriteNode(imageNamed: "OrbTree")
        initialOrb.position = CGPointMake(self.frame.width/2, self.frame.height/2 + 30)
        initialOrb.size = CGSize(width: self.frame.width/3, height: self.frame.width/3)
        self.addChild(initialOrb)
        
        var labelPosition = CGPoint(x: initialOrb.position.x, y: initialOrb.position.y - initialOrb.size.height/1.25)
        
        orbTitle = SKLabelNode(text: "Orbilis")
        orbTitle.fontName = "Avenir-Roman"
        orbTitle.position = labelPosition
        self.addChild(orbTitle)
        
        labelPosition = CGPoint(x: labelPosition.x, y: labelPosition.y - initialOrb.size.height/1.25 + 35)
        
        orbPlay = SKLabelNode(text: "tap to play")
        orbPlay.fontSize = 12
        orbPlay.fontName = "Avenir-Roman"
        orbPlay.position = labelPosition
        self.addChild(orbPlay)
        
        //tutorial
        
        labelPosition = CGPoint(x: labelPosition.x, y: labelPosition.y - initialOrb.size.height/1.25 - 30)
        
        orbTutorial = SKLabelNode(text: "Tutorial")
        orbTutorial.position = labelPosition
        orbTutorial.fontSize = 22
        orbTutorial.name = "tutorial"
        orbTutorial.fontName = "Avenir-Roman"
        self.addChild(orbTutorial)
        
        
//        Check if First Time
        
        UserData.initializePlist()
        
    }
    
    override func touchesBegan(touches: Set<NSObject>, withEvent event: UIEvent) {
        /* Called when a touch begins */
        
        for touch in (touches as! Set<UITouch>) {
            
            var name = nodeAtPoint(touch.locationInNode(self)).name
            
            if name == "tutorial" {
                
                gotoTut()
                
                UserData.setAlreadyUser(1)
            }
            
            else {
                
                if UserData.isFirstTime() == 0 {
                    
                    var alert = UIAlertView(title: "Do you want to play the tutorial?", message: "It is highly recommended! If not, you can acess it tapping on 'Tutorial' on the bottom of the screen.", delegate: self, cancelButtonTitle: "Yes Please!", otherButtonTitles: "No, Thanks")
                    alert.show()
                    
                    UserData.setAlreadyUser(1)
                    
                } else {
                    
                    gotoGame()
                    
                }
           
            }
            
        }
        
    }
    
    func gotoGame() {
        
        var fadeOut = SKAction.fadeOutWithDuration(animationDuration)
        initialOrb.texture = SKTexture(imageNamed: "OrbPure")
        var moveToCenter = SKAction.moveToY(self.frame.height/2, duration: animationDuration)
        moveToCenter.timingMode = SKActionTimingMode.EaseInEaseOut
        var increaseSize = SKAction.resizeToWidth(self.frame.width, height: self.frame.width, duration: animationDuration)
        increaseSize.timingMode = SKActionTimingMode.EaseInEaseOut
        var wait = SKAction.waitForDuration(animationDuration)
        var group = SKAction.group([moveToCenter,increaseSize])
        var block = SKAction.runBlock({
            
            var scene = GameScene(size:self.size)
            
            self.scene!.view?.presentScene(scene, transition: SKTransition.crossFadeWithDuration(0.1))
            
        })
        var sequenceOrb = SKAction.sequence([wait,group,block])
        
        self.orbPlay.runAction(fadeOut)
        self.orbTitle.runAction(fadeOut)
        self.orbTutorial.runAction(fadeOut)
        self.initialOrb.runAction(sequenceOrb)
    }
    
    func gotoTut() {
        
        var fadeOut = SKAction.fadeOutWithDuration(animationDuration)
        initialOrb.texture = SKTexture(imageNamed: "OrbPure")
        var moveToCenter = SKAction.moveToY(self.frame.height/2, duration: animationDuration)
        moveToCenter.timingMode = SKActionTimingMode.EaseInEaseOut
        var increaseSize = SKAction.resizeToWidth(self.frame.width, height: self.frame.width, duration: animationDuration)
        increaseSize.timingMode = SKActionTimingMode.EaseInEaseOut
        var wait = SKAction.waitForDuration(animationDuration)
        var group = SKAction.group([moveToCenter,increaseSize])
        var block = SKAction.runBlock({
            
            var scene = TutorialScene(size:self.size)
            
            self.scene!.view?.presentScene(scene, transition: SKTransition.crossFadeWithDuration(0.1))
            
        })
        var sequenceOrb = SKAction.sequence([wait,group,block])
        
        self.orbPlay.runAction(fadeOut)
        self.orbTitle.runAction(fadeOut)
        self.orbTutorial.runAction(fadeOut)
        self.initialOrb.runAction(sequenceOrb)
        
    }
    
    func alertView(alertView: UIAlertView, clickedButtonAtIndex buttonIndex: Int) {
        if(buttonIndex == 0) {
            gotoTut()
            
        } else {
            gotoGame()
        }
    }
    
    override func update(currentTime: CFTimeInterval) {
        /* Called before each frame is rendered */
    }
   
}
