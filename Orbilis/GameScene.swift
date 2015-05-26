//
//  GameScene.swift
//  Orbilis
//
//  Created by Joao Nassar Galante Guedes on 23/05/15.
//  Copyright (c) 2015 Joao Nassar Galante Guedes. All rights reserved.
//

import SpriteKit

class GameScene: SKScene {
    
    var sizeOfSprites: CGFloat = 20
    var tickTime = 0.5
    var tickTimer = NSTimer()
    var audioManager = AudioManager()
    
    var pointOrganicMatter = CGPointMake(0, 0)
    var pointOrganicMatterLabel = CGPointMake(0, 0)
    
    var menuIsOpen = false
    var screenPressed = false
    
    var backgroundSprite = SKSpriteNode()
    var orbBackground = SKSpriteNode()
    var islandSprite = SKSpriteNode()
    var orbGlass = SKSpriteNode()
    var orbWater = SKSpriteNode()
    var orbSand = SKSpriteNode()
    
    var creaturesArray: Array<Lifeform> = []
    var buildingsArray: Array<Building> = []
    
    var pauseButton: SKSpriteNode?
    var organicMatterImage: SKSpriteNode?
    var descriptor: SKSpriteNode?
    var descriptorLabel: SKLabelNode?
    
    var menuButtons: Array<SKSpriteNode> = []
    var menuCosts: Array<SKLabelNode> = []
    
    var organicMatterLabel: SKLabelNode?
    var presentTimeLabel: SKLabelNode?
    
    var presentTime = 0
    var pollution = 0
    var organicMatter = 356
    
    override func didMoveToView(view: SKView) {
        /* Setup your scene here */
        
        drawOrb()
        drawInfo()
        drawItensMenu()
        
        updateTick()
    }
    
    func drawOrb() {
        backgroundSprite = SKSpriteNode(imageNamed: "RectGreen")
        backgroundSprite.size = CGSizeMake(self.frame.size.width - 40, self.frame.size.width - 40)
        backgroundSprite.position = CGPointMake(CGRectGetMidX(self.frame), CGRectGetMidY(self.frame))
        self.addChild(backgroundSprite)
        
        islandSprite = SKSpriteNode(imageNamed: "RectRed")
        islandSprite.size = CGSizeMake(self.frame.size.width/2, self.frame.size.width/4)
        islandSprite.position = CGPointMake(CGRectGetMidX(self.frame), CGRectGetMidY(self.frame) - islandSprite.frame.size.height/2)
        self.addChild(islandSprite)
    }
    
    func drawInfo() {
        
        descriptor = SKSpriteNode()
        descriptor!.size = CGSizeMake(self.frame.size.width/3, self.frame.size.width/3)
        descriptor!.position = CGPointMake(CGRectGetMidX(self.frame), CGRectGetMidY(self.frame) + backgroundSprite.frame.size.height/2 + descriptor!.frame.size.height/2)
        descriptor!.alpha = 0
        descriptor!.zPosition = 2
        self.addChild(descriptor!)
        
        redrawOrganicMatter()
        
        redrawPresentTime()
        
    }
    
    func redrawOrganicMatter() {
        
        organicMatterImage = SKSpriteNode(imageNamed: "RectOrange")
        organicMatterImage!.size = CGSizeMake(self.frame.size.width/10, self.frame.size.width/10)
        organicMatterImage!.zPosition = 2
        self.addChild(organicMatterImage!)
        
        organicMatterLabel = SKLabelNode()
        organicMatterLabel!.text = "\(organicMatter)"
        organicMatterLabel!.zPosition = 2
        self.addChild(organicMatterLabel!)
        
        var difference = organicMatterLabel!.frame.size.width - organicMatterImage!.frame.size.width
        
        var y = (CGRectGetMidY(self.frame) - backgroundSprite.frame.size.height/2)/2
        var x = CGRectGetMidX(self.frame) - organicMatterImage!.frame.size.width/2 - difference
        
        organicMatterImage!.position = CGPointMake(x, y)
        pointOrganicMatter.x = organicMatterImage!.position.x
        pointOrganicMatter.y = organicMatterImage!.position.y
        
        organicMatterLabel!.position = CGPointMake(x + organicMatterLabel!.frame.size.width, y - organicMatterLabel!.frame.size.height/2)
        pointOrganicMatterLabel.x = organicMatterLabel!.position.x
        pointOrganicMatterLabel.y = organicMatterLabel!.position.y
    }
    
    func redrawPresentTime() {
        presentTimeLabel = SKLabelNode()
        presentTimeLabel!.text = "\(presentTime)"
        presentTimeLabel!.position = CGPointMake(presentTimeLabel!.frame.size.width/2 + 10, self.frame.height - presentTimeLabel!.frame.size.height/2 - 20)
        presentTimeLabel!.zPosition = 2
        self.addChild(presentTimeLabel!)
    }
    
    func drawItensMenu() {
        
        var menuItens = Actions.getActionsArray()
        
        var count = CGFloat(menuItens.count)
        var buttonsSpace:CGFloat = 40
        var buttonSize:CGFloat = (self.frame.size.width - buttonsSpace*(count + 1))/count
        
        var counter:CGFloat = 1
        
        for i in menuItens {
            
            var x = counter*buttonsSpace + buttonSize/2 + (counter-1)*buttonSize
            var y:CGFloat = (CGRectGetMidY(self.frame) - backgroundSprite.frame.size.height/2)/2
            
            var button = SKSpriteNode(imageNamed: "RectRed")
            button.size = CGSizeMake(buttonSize, buttonSize)
            button.position = CGPointMake(x, y)
            button.name = i
            button.alpha = 0
            button.zPosition = 2
            menuButtons.append(button)
            self.addChild(button)
            
            var label = SKLabelNode()
            label.text = "\(Actions.getActionCost(i))"
            label.position = CGPointMake(x, y - buttonSize/2 - label.frame.size.height/2 - 20)
            label.alpha = 0
            label.zPosition = 2
            menuCosts.append(label)
            self.addChild(label)
            
            counter++
        }
    }
    
    func openItensMenu() {
        if(screenPressed==true) {
            //Show itens menu
            var action = SKAction.fadeAlphaTo(1, duration: 0.2)
            var move = SKAction.moveTo(CGPointMake(pointOrganicMatter.x, CGRectGetMidY(self.frame) - backgroundSprite.frame.size.height/2 - organicMatterImage!.frame.size.height/2), duration: 0.2)
            var moveText = SKAction.moveTo(CGPointMake(pointOrganicMatterLabel.x, CGRectGetMidY(self.frame) - backgroundSprite.frame.size.height/2 - organicMatterImage!.frame.size.height/2 - organicMatterLabel!.frame.size.height/2), duration: 0.2)
            
            for i in menuButtons {
                i.runAction(action)
            }
            for i in menuCosts {
                i.runAction(action)
            }
            
            organicMatterImage?.runAction(move)
            organicMatterLabel?.runAction(moveText)
        }
    }
    
    func closeItensMenu() {
        //Show itens menu
        var action = SKAction.fadeAlphaTo(0, duration: 0.2)
        var move = SKAction.moveTo(CGPointMake(pointOrganicMatter.x, pointOrganicMatter.y), duration: 0.2)
        var moveText = SKAction.moveTo(CGPointMake(pointOrganicMatterLabel.x, pointOrganicMatterLabel.y), duration: 0.2)
        
        for i in menuButtons {
            i.runAction(action)
        }
        for i in menuCosts {
            i.runAction(action)
        }
        
        organicMatterImage?.runAction(move)
        organicMatterLabel?.runAction(moveText)
    }
    
    func showDescriptorToMenu(type: String) {
        var action = SKAction.fadeAlphaTo(1, duration: 0.2)
        descriptor!.runAction(action)
        descriptor!.texture = Actions.getActionDescriptor(type)
    }
    
    func hideDescriptor() {
        var action = SKAction.fadeAlphaTo(0, duration: 0.2)
        descriptor!.runAction(action)
    }
    
    override func touchesBegan(touches: Set<NSObject>, withEvent event: UIEvent) {
        /* Called when a touch begins */
        screenPressed = true
        
        for touch in (touches as! Set<UITouch>) {
            
            var name = nodeAtPoint(touch.locationInNode(self)).name
            
            if name == "MenuButton" {
                //Open pause menu
            } else {
                NSTimer.scheduledTimerWithTimeInterval(0.1, target: self, selector: Selector("openItensMenu"), userInfo: nil, repeats: false)
            }
        }

    }
    
    override func touchesMoved(touches: Set<NSObject>, withEvent event: UIEvent) {
       
        hideDescriptor()
        
        for touch in (touches as! Set<UITouch>) {
            
            var name = nodeAtPoint(touch.locationInNode(self)).name
            
            var options = Actions.getActionsArray()
            
            for i in options {
                if name == i {
                    showDescriptorToMenu(i)
                }
            }
            
            
        }
    }
    
    override func touchesEnded(touches: Set<NSObject>, withEvent event: UIEvent) {
        screenPressed = false
        
        hideDescriptor()
        closeItensMenu()
        
        for touch in (touches as! Set<UITouch>) {
            
            var name = nodeAtPoint(touch.locationInNode(self)).name
            
            var options = Actions.getActionsArray()
            
            for i in options {
                if name == i {
                    spawnEntity(i)
                }
            }
        }
    }
    
    func updateTick() {
        
        deleteMarkedEntities()
        checkForCollisions()
        moveAndAgeEntities()
        calculatePollution()
        
        tickTimer = NSTimer.scheduledTimerWithTimeInterval(tickTime, target: self, selector: Selector("updateTick"), userInfo: nil, repeats: false)
    }
    
    func deleteMarkedEntities() {
        
        //PODE TER ERRO AQUI!!!!!
        for var i = 0; i<creaturesArray.count; i++ {
            if(creaturesArray[i].aboutToDelete == 1) {
                creaturesArray[i].die()
                creaturesArray.removeAtIndex(i)
            }
        }
    }
    
    func checkForCollisions() {
        
        for var i = 0; i < creaturesArray.count; i++ {
            for var j = 0; j < creaturesArray.count; j++ {
                if(i != j) {
                    if(CGRectIntersectsRect(creaturesArray[i].frame, creaturesArray[j].frame)) {
                        if(creaturesArray[i].aboutToDelete == 0 && creaturesArray[j].aboutToDelete == 0)
                        {
                            manageCollision(creaturesArray[i],c2: creaturesArray[j])
                        }
                    }
                }
            }
        }
    }
    
    func manageCollision(c1: Lifeform, c2: Lifeform) {
        
        var interaction1 = c1.interact(c2)
        if(interaction1 == true) {
            var new = c1.reproduce()
            if(new != nil) {
                creaturesArray.append(new!)
                islandSprite.addChild(new!)
            }
        }
        
        var interaction2 = c2.interact(c1)
        if(interaction2 == true) {
            var new = c2.reproduce()
            if(new != nil) {
                creaturesArray.append(new!)
                islandSprite.addChild(new!)
            }
        }
    }
    
    func moveAndAgeEntities() {
        
        for i in creaturesArray {
            i.move(islandSprite.frame,time: tickTime)
            if(i.lifeTime > i.lifeTimeMax) {
                i.animateToDie()
                i.aboutToDelete = 1
                organicMatter++
            }
        }
    }
    
    func spawnEntity(type: String) {
        
        var new = Actions.executeAction(type, size: sizeOfSprites, rect: islandSprite.frame)
        if(new.node != nil) {
            if(new.type == "Lifeform") {
                creaturesArray.append(new.node! as! Lifeform)
                self.islandSprite.addChild(new.node! as! Lifeform)
            } else if (new.type == "Building") {
                
            }
        }
    }
    
    func calculatePollution() {
        
        for i in buildingsArray {
            pollution += i.pollutionRate
        }
        
        for i in creaturesArray {
            pollution -= i.pollutionIncrement
        }
        
        //Show weather effects according to pollution here
        
    }
    
    func rain() {
        
    }
    
    func smoke() {
        
    }
    
    func acidRain() {
        
    }
    
    func darkenColor() {
        
    }
    
    func loseGame() {
        //Anima enchete e abre proxima cena.
    }
    
    override func update(currentTime: CFTimeInterval) {
        /* Called before each frame is rendered */
    }
    
}
