//
//  GameScene.swift
//  Orbilis
//
//  Created by Joao Nassar Galante Guedes on 23/05/15.
//  Copyright (c) 2015 Joao Nassar Galante Guedes. All rights reserved.
//

import SpriteKit

class GameScene: SKScene {
    
    var pollutionLimits = [0,100,200,300,500,600,700]
    
    var timeSpeed = 0
    
    var sizeOfSprites: CGFloat = 20
    var tickTime = 1.0
    var tickTimer = NSTimer()
    var audioManager = AudioManager()
    
    var chanceToSpawnFactory = 10
    
    var pointOrganicMatter = CGPointMake(0, 0)
    var pointOrganicMatterLabel = CGPointMake(0, 0)
    
    var menuIsOpen = false
    var screenPressed = false
    var lostGame = false
    
    var islandRect = SKSpriteNode()
    
    var backgroundSprite = SKSpriteNode()
    var orbBackgroundBad = SKSpriteNode()
    var orbBackground = SKSpriteNode()
    var islandSprite = SKSpriteNode()
    var orbGlass = SKSpriteNode()
    var orbWaterBad = SKSpriteNode()
    var orbWaterFlood = SKSpriteNode()
    var orbWater = SKSpriteNode()
    var orbCloud = SKSpriteNode()
    var orbBadCloud = SKSpriteNode()
    var orbSmoke = SKSpriteNode()
    var orbSmokeLess = SKSpriteNode()
    
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
        
        var background = SKSpriteNode(imageNamed: "Background")
        background.size = CGSizeMake(self.frame.size.width, self.frame.size.height)
        background.position = CGPointMake(CGRectGetMidX(self.frame), CGRectGetMidY(self.frame))
        background.zPosition = -1
        background.name = "TheBackground"
        self.addChild(background)
        
        drawOrb()
        drawInfo()
        drawItensMenu()
        
        updateTick()
    }
    
    func drawOrb() {
        //Joao
        var spacing: CGFloat = 40
        var islandW: CGFloat = 390
        var islandH: CGFloat = islandW/2
        
        var prop: CGFloat = self.frame.size.width/640
        var deloc: CGFloat = -35 * prop
        
        islandW = islandW * prop
        islandH = islandH * prop
        
        backgroundSprite = SKSpriteNode(imageNamed: "NormalBackground")
        backgroundSprite.size = CGSizeMake(self.frame.size.width - spacing, self.frame.size.width - spacing)
        backgroundSprite.position = CGPointMake(CGRectGetMidX(self.frame), CGRectGetMidY(self.frame))
        backgroundSprite.zPosition = 0
        self.addChild(backgroundSprite)
        
        orbBackgroundBad = SKSpriteNode(imageNamed: "BadBackground")
        orbBackgroundBad.size = CGSizeMake(self.frame.size.width - spacing, self.frame.size.width - spacing)
        orbBackgroundBad.position = CGPointMake(CGRectGetMidX(self.frame), CGRectGetMidY(self.frame))
        orbBackgroundBad.zPosition = 1
        orbBackgroundBad.alpha = 0
        self.addChild(orbBackgroundBad)
        
        orbWaterBad = SKSpriteNode(imageNamed: "BadIsland")
        orbWaterBad.size = CGSizeMake(self.frame.size.width - spacing, self.frame.size.width - spacing)
        orbWaterBad.position = CGPointMake(CGRectGetMidX(self.frame), CGRectGetMidY(self.frame))
        orbWaterBad.zPosition = 2
        orbWaterBad.alpha = 0
        self.addChild(orbWaterBad)
        
        orbWaterFlood = SKSpriteNode(imageNamed: "FloodIsland")
        orbWaterFlood.size = CGSizeMake(self.frame.size.width - spacing, self.frame.size.width - spacing)
        orbWaterFlood.position = CGPointMake(CGRectGetMidX(self.frame), CGRectGetMidY(self.frame))
        orbWaterFlood.zPosition = 2
        orbWaterFlood.alpha = 0
        self.addChild(orbWaterFlood)
        
        orbWater = SKSpriteNode(imageNamed: "NormalIsland")
        orbWater.size = CGSizeMake(self.frame.size.width - spacing, self.frame.size.width - spacing)
        orbWater.position = CGPointMake(CGRectGetMidX(self.frame), CGRectGetMidY(self.frame))
        orbWater.zPosition = 1
        self.addChild(orbWater)
        
        orbCloud = SKSpriteNode(imageNamed: "GoodCloud")
        orbCloud.size = CGSizeMake(self.frame.size.width - spacing, self.frame.size.width - spacing)
        orbCloud.position = CGPointMake(CGRectGetMidX(self.frame), CGRectGetMidY(self.frame))
        orbCloud.zPosition = 5
        orbCloud.alpha = 0
        self.addChild(orbCloud)
        
        orbBadCloud = SKSpriteNode(imageNamed: "BadCloud")
        orbBadCloud.size = CGSizeMake(self.frame.size.width - spacing, self.frame.size.width - spacing)
        orbBadCloud.position = CGPointMake(CGRectGetMidX(self.frame), CGRectGetMidY(self.frame))
        orbBadCloud.zPosition = 5
        orbBadCloud.alpha = 0
        self.addChild(orbBadCloud)
        
        orbSmoke = SKSpriteNode(imageNamed: "Smoke")
        orbSmoke.size = CGSizeMake(self.frame.size.width - spacing, self.frame.size.width - spacing)
        orbSmoke.position = CGPointMake(CGRectGetMidX(self.frame), CGRectGetMidY(self.frame))
        orbSmoke.zPosition = 5
        orbSmoke.alpha = 0
        self.addChild(orbSmoke)
        
        orbSmokeLess = SKSpriteNode(imageNamed: "PollutionSmokeLess")
        orbSmokeLess.size = CGSizeMake(self.frame.size.width - spacing, self.frame.size.width - spacing)
        orbSmokeLess.position = CGPointMake(CGRectGetMidX(self.frame), CGRectGetMidY(self.frame))
        orbSmokeLess.zPosition = 2
        orbSmokeLess.alpha = 0
        self.addChild(orbSmokeLess)
        
        orbGlass = SKSpriteNode(imageNamed: "GlassCover")
        orbGlass.size = CGSizeMake(self.frame.size.width - spacing, self.frame.size.width - spacing)
        orbGlass.position = CGPointMake(CGRectGetMidX(self.frame), CGRectGetMidY(self.frame))
        orbGlass.zPosition = 6
        self.addChild(orbGlass)
        
        islandSprite = SKSpriteNode()
        islandSprite.size = CGSizeMake(islandW, islandH)
        islandSprite.position = CGPointMake(CGRectGetMidX(self.frame), CGRectGetMidY(self.frame) - deloc)
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
        descriptorLabel!.fontName = "Avenir-Roman"
        descriptorLabel!.fontSize = 18
            descriptorLabel!.position = CGPointMake(CGRectGetMidX(self.frame), descriptor!.position.y - descriptor!.frame.size.height/2 - descriptorLabel!.frame.size.height/2 - space)
        descriptorLabel!.alpha = 1
        descriptorLabel!.zPosition = 2
        self.addChild(descriptorLabel!)
        
    }
    
    func redrawOrganicMatter() {
        
        organicMatterImage = SKSpriteNode(imageNamed: "OrganicImage")
        organicMatterImage!.size = CGSizeMake(self.frame.size.width/10, self.frame.size.width/10)
        organicMatterImage!.zPosition = 2
        self.addChild(organicMatterImage!)
        
        organicMatterLabel?.removeFromParent()
        organicMatterLabel = SKLabelNode()
        organicMatterLabel!.text = "\(organicMatter)"
        organicMatterLabel!.fontName = "Avenir-Roman"
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
        presentTimeLabel!.fontSize = 20
        presentTimeLabel!.fontName = "Avenir-Roman"
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
            
            var button = Actions.getActionButton(i)
            button!.size = CGSizeMake(buttonSize, buttonSize)
            button!.position = CGPointMake(x, y)
            button!.name = i
            button!.alpha = 0
            button!.zPosition = 2
            menuButtons.append(button!)
            self.addChild(button!)
            
            var label = SKLabelNode()
            label.text = "\(Actions.getActionCost(i))"
            label.fontSize = 16
            label.fontName = "Avenir-Roman"
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
        
        if(lostGame == false) {
            for touch in (touches as! Set<UITouch>) {
                
                var name = nodeAtPoint(touch.locationInNode(self)).name
                
                if name == "MenuButton" {
                    //Open pause menu
                } else {
                    NSTimer.scheduledTimerWithTimeInterval(0.1, target: self, selector: Selector("openItensMenu"), userInfo: nil, repeats: false)
                }
            }
        }

    }
    
    override func touchesMoved(touches: Set<NSObject>, withEvent event: UIEvent) {
       
        hideDescriptor()
        
        if(lostGame == false) {
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
    }
    
    override func touchesEnded(touches: Set<NSObject>, withEvent event: UIEvent) {
        screenPressed = false
        
        hideDescriptor()
        closeItensMenu()
        
        if(lostGame == false) {
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
    }
    
    func updateTick() {
        
        if(lostGame == false && menuIsOpen == false) {
            deleteMarkedEntities()
            checkForCollisions()
            moveAndAgeEntities()
            calculatePollution()
            chanceSpawnFactory()
            
            presentTime++
            
            redrawPresentTime()
            
            tickTimer = NSTimer.scheduledTimerWithTimeInterval(tickTime, target: self, selector: Selector("updateTick"), userInfo: nil, repeats: false)
        }
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
            pollution += i.pollutionIncrement
        }
        
        if(pollution < 0) {
            pollution = 0
        }
        
        if(pollution >= pollutionLimits[6]) {
            loseGame()
        } else if(pollution >= pollutionLimits[5]) {
            darkenColor()
        } else if(pollution >= pollutionLimits[4]) {
            backDark()
        } else if(pollution >= pollutionLimits[3]) {
            acidRain()
        } else if(pollution >= pollutionLimits[2]) {
            smoke()
        } else if(pollution >= pollutionLimits[1]) {
            smokeLess()
        } else if(pollution >= pollutionLimits[0]) {
            rain()
        }
        
        for i in creaturesArray {
            if(i.chanceToDie(pollution) == true) {
                i.animateToDie()
                i.aboutToDelete = 1
            }
        }
    }
    
    func chanceSpawnFactory() {
        
        var r = random(1...chanceToSpawnFactory)
        
        if(r<=1) {
            executeGameAction("AddFactory")
        }
        
    }
    
    func rain() {
        var vanish = SKAction.fadeAlphaTo(0, duration: 1.0)
        orbSmoke.runAction(vanish)
        orbBadCloud.runAction(vanish)
        orbBackgroundBad.runAction(vanish)
        orbWaterBad.runAction(vanish)
        orbSmokeLess.runAction(vanish)
    }
    
    func smokeLess() {
        var vanish = SKAction.fadeAlphaTo(0, duration: 1.0)
        orbSmoke.runAction(vanish)
        orbBadCloud.runAction(vanish)
        orbBackgroundBad.runAction(vanish)
        orbWaterBad.runAction(vanish)
        
        var action = SKAction.fadeAlphaTo(0.7, duration: 1.0)
        orbSmokeLess.runAction(action)
    }
    
    func smoke() {
        var vanish = SKAction.fadeAlphaTo(0, duration: 1.0)
        orbSmokeLess.runAction(vanish)
        orbBadCloud.runAction(vanish)
        orbBackgroundBad.runAction(vanish)
        orbWaterBad.runAction(vanish)
        
        var action = SKAction.fadeAlphaTo(0.7, duration: 1.0)
        orbSmoke.runAction(action)
    }
    
    func acidRain() {
        var vanish = SKAction.fadeAlphaTo(0, duration: 1.0)
        orbBackgroundBad.runAction(vanish)
        orbWaterBad.runAction(vanish)
        
        var action = SKAction.fadeAlphaTo(1, duration: 1.0)
        orbBadCloud.runAction(action)

    }
    
    func backDark() {
        var vanish = SKAction.fadeAlphaTo(0, duration: 1.0)
        orbWaterBad.runAction(vanish)
        
        var action2 = SKAction.fadeAlphaTo(1, duration: 1.0)
        orbBackgroundBad.runAction(action2)
    }
    
    func darkenColor() {
        var vanish = SKAction.fadeAlphaTo(0, duration: 1.0)
        
        var action = SKAction.fadeAlphaTo(1, duration: 1.0)
        orbWaterBad.runAction(action)
    }
    
    func loseGame() {
        lostGame = true
        var vanish = SKAction.fadeAlphaTo(0, duration: 1.0)
        islandSprite.runAction(vanish)
        var action = SKAction.fadeAlphaTo(1, duration: 1.0)
        orbWaterFlood.runAction(action)
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
    
    func lostLevelTransition() {
        
    }
    
    override func update(currentTime: CFTimeInterval) {
        /* Called before each frame is rendered */
    }
    
}
