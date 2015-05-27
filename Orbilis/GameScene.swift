//
//  GameScene.swift
//  Orbilis
//
//  Created by Joao Nassar Galante Guedes on 23/05/15.
//  Copyright (c) 2015 Joao Nassar Galante Guedes. All rights reserved.
//

import SpriteKit

class GameScene: SKScene {
    
    var pollutionLimits = [0,100,200,300,500]
    
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
    var orbCloud = SKSpriteNode()
    
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
        //Joao
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
        //Joao
        var textSize:CGFloat = 30
        
        descriptor = SKSpriteNode()
        descriptor!.size = CGSizeMake(self.frame.size.width/6, self.frame.size.width/6)
        descriptor!.position = CGPointMake(CGRectGetMidX(self.frame), CGRectGetMidY(self.frame) + backgroundSprite.frame.size.height/2 + descriptor!.frame.size.height/2 + textSize)
        descriptor!.alpha = 0
        descriptor!.zPosition = 2
        self.addChild(descriptor!)
        
        redrawDescriptorText("")
        
        redrawOrganicMatter()
        
        redrawPresentTime()
        
    }
    
    func redrawDescriptorText(text: String) {
        
        var space:CGFloat = 15
        
        descriptorLabel?.removeFromParent()
        descriptorLabel = SKLabelNode()
        descriptorLabel!.text = text
        descriptorLabel!.fontSize = 18
            descriptorLabel!.position = CGPointMake(CGRectGetMidX(self.frame), descriptor!.position.y - descriptor!.frame.size.height/2 - descriptorLabel!.frame.size.height/2 - space)
        descriptorLabel!.alpha = 1
        descriptorLabel!.zPosition = 2
        self.addChild(descriptorLabel!)
        
    }
    
    func redrawOrganicMatter() {
        
        organicMatterImage = SKSpriteNode(imageNamed: "RectOrange")
        organicMatterImage!.size = CGSizeMake(self.frame.size.width/10, self.frame.size.width/10)
        organicMatterImage!.zPosition = 2
        self.addChild(organicMatterImage!)
        
        organicMatterLabel?.removeFromParent()
        organicMatterLabel = SKLabelNode()
        organicMatterLabel!.text = "\(organicMatter)"
        organicMatterLabel!.fontSize = 18
        organicMatterLabel!.zPosition = 2
        self.addChild(organicMatterLabel!)
        
        var space:CGFloat = 10
        
        var difference = organicMatterLabel!.frame.size.width - organicMatterImage!.frame.size.width + space/2
        
        var y = (CGRectGetMidY(self.frame) - backgroundSprite.frame.size.height/2)/2
        var x = CGRectGetMidX(self.frame) - organicMatterImage!.frame.size.width/2 - difference
        
        organicMatterImage!.position = CGPointMake(x, y)
        pointOrganicMatter.x = organicMatterImage!.position.x
        pointOrganicMatter.y = organicMatterImage!.position.y
        
        organicMatterLabel!.position = CGPointMake(x + organicMatterLabel!.frame.size.width + space, y - organicMatterLabel!.frame.size.height/2)
        pointOrganicMatterLabel.x = organicMatterLabel!.position.x
        pointOrganicMatterLabel.y = organicMatterLabel!.position.y
    }
    
    func redrawPresentTime() {
        presentTimeLabel?.removeFromParent()
        presentTimeLabel = SKLabelNode()
        presentTimeLabel!.text = "\(presentTime)d"
        presentTimeLabel!.position = CGPointMake(presentTimeLabel!.frame.size.width/2 + 10, self.frame.height - presentTimeLabel!.frame.size.height/2 - 20)
        presentTimeLabel!.zPosition = 2
        self.addChild(presentTimeLabel!)
    }
    
    func drawItensMenu() {
        
        var menuItens = Actions.getActionsArray()
        
        var count = CGFloat(menuItens.count)
        
        var textSize:CGFloat = 20
        
        var buttonSize:CGFloat = ((CGRectGetMidY(self.frame) - backgroundSprite.frame.size.height/2) - (self.frame.size.width/10) - (textSize + 10))
        var buttonsSpace:CGFloat = 0
        
        if(buttonSize * CGFloat(menuItens.count) >= self.frame.size.width - 10) {
            buttonSize = buttonSize - 30
            buttonsSpace = (self.frame.size.width - (buttonSize * CGFloat(menuItens.count)))/CGFloat(menuItens.count + 1)
        } else {
            buttonsSpace = (self.frame.size.width - (buttonSize * CGFloat(menuItens.count)))/CGFloat(menuItens.count + 1)
        }
        
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
            label.fontSize = 16
            label.position = CGPointMake(x, y - buttonSize/2 - label.frame.size.height/2 - (textSize - 10))
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
        descriptorLabel!.runAction(action)
        redrawDescriptorText(Actions.getActionText(type)!)
    }
    
    func hideDescriptor() {
        var action = SKAction.fadeAlphaTo(0, duration: 0.2)
        descriptor!.runAction(action)
        descriptorLabel!.runAction(action)
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
                    if(organicMatter < Actions.getActionCost(i)) {
                        //Not enough matter
                    } else {
                        executeGameAction(i)
                        organicMatterLabel?.text = "\(organicMatter)"
                    }
                    
                }
            }
        }
    }
    
    func updateTick() {
        
        deleteMarkedEntities()
        checkForCollisions()
        moveAndAgeEntities()
        calculatePollution()
        chanceSpawnFactory()
        
        presentTime++
        
        redrawPresentTime()
        
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
            if(i.lifeTime > i.lifeTimeMax && i.aboutToDelete == 0) {
                i.animateToDie()
                i.aboutToDelete = 1
                organicMatter += i.organicProduction
                organicMatterLabel?.text = "\(organicMatter)"
            }
        }
    }
    
    func executeGameAction(type: String) {
        
        var new = Actions.executeAction(type, size: sizeOfSprites, rect: islandSprite.frame)
        
        if(new.node != nil) {
            if(new.type == "Lifeform") {
                creaturesArray.append(new.node! as! Lifeform)
                self.islandSprite.addChild(new.node! as! Lifeform)
                organicMatter -= Actions.getActionCost(type)
            } else if (new.type == "Building") {
                buildingsArray.append(new.node! as! Building)
                self.islandSprite.addChild(new.node! as! Building)
            } else if (new.type == "RemoveFactory") {
                if(buildingsArray.count >= 1) {
                    buildingsArray[0].destroy()
                    buildingsArray.removeAtIndex(0)
                    organicMatter -= Actions.getActionCost(type)
                }
            }
        }
    }
    
    func calculatePollution() {
        
        println(pollution)
        
        for i in buildingsArray {
            pollution += i.pollutionRate
        }
        
        for i in creaturesArray {
            pollution -= i.pollutionIncrement
        }
        
        if(pollution < 0) {
            pollution = 0
        }
        
        if(pollution <= pollutionLimits[0]) {
            rain()
        } else if(pollution <= pollutionLimits[1]) {
            smoke()
        } else if(pollution <= pollutionLimits[2]) {
            acidRain()
        } else if(pollution <= pollutionLimits[3]) {
            darkenColor()
        } else if(pollution <= pollutionLimits[4]) {
            loseGame()
        }
    }
    
    func chanceSpawnFactory() {
        
        var r = random(1...10)
        
        if(r<=1) {
            executeGameAction("AddFactory")
        }
        
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
    
    func random(range: Range<Int> ) -> Int
    {
        var offset = 0
        
        if range.startIndex < 0
        {
            offset = abs(range.startIndex)
        }
        
        let mini = UInt32(range.startIndex + offset)
        let maxi = UInt32(range.endIndex   + offset)
        
        return Int(mini + arc4random_uniform(maxi - mini)) - offset
    }
    
    override func update(currentTime: CFTimeInterval) {
        /* Called before each frame is rendered */
    }
    
}
