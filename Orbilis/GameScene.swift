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
    
    var menuIsOpen = false
    
    var backgroundSprite = SKSpriteNode()
    var orbBackground = SKSpriteNode()
    var islandSprite = SKSpriteNode()
    var orbGlass = SKSpriteNode()
    var orbWater = SKSpriteNode()
    var orbSand = SKSpriteNode()
    
    var creaturesArray: Array<Lifeform> = []
    var buildingsArray: Array<Building> = []
    
    var pauseButton: SKSpriteNode?
    var addTreeButton: SKSpriteNode?
    var addHerbivoreButton: SKSpriteNode?
    var addCarnivoreButton: SKSpriteNode?
    var removeBuildingButton: SKSpriteNode?
    var organicMatterImage: SKSpriteNode?
    var descriptor: SKSpriteNode?
    
    var organicMatterLabel: SKLabelNode?
    var presentTimeLabel: SKLabelNode?
    
    var presentTime = 0
    var pollution = 0
    var organicMatter = 0
    
    override func didMoveToView(view: SKView) {
        /* Setup your scene here */
        
        var swipeLeft = UISwipeGestureRecognizer(target: self, action: Selector("swipeLeft"))
        swipeLeft.direction = UISwipeGestureRecognizerDirection.Left
        self.view?.addGestureRecognizer(swipeLeft)
        
        var swipeRight = UISwipeGestureRecognizer(target: self, action: Selector("swipeRight"))
        swipeRight.direction = UISwipeGestureRecognizerDirection.Right
        self.view?.addGestureRecognizer(swipeRight)
        
        drawOrb()
        drawInfo()
        drawItensMenu()
        
        updateTick()
    }
    
    func drawOrb() {
        var backgroundSprite = SKSpriteNode(imageNamed: "RectGreen")
        backgroundSprite.size = CGSizeMake(self.frame.size.width/2, self.frame.size.width/2)
        backgroundSprite.position = CGPointMake(CGRectGetMidX(self.frame), CGRectGetMidY(self.frame))
        self.addChild(backgroundSprite)
        
        islandSprite = SKSpriteNode(imageNamed: "RectRed")
        islandSprite.size = CGSizeMake(self.frame.size.width/2, self.frame.size.width/4)
        islandSprite.position = CGPointMake(CGRectGetMidX(self.frame), CGRectGetMidY(self.frame) - islandSprite.frame.size.height/2)
        self.addChild(islandSprite)
    }
    
    func drawInfo() {
        
    }
    
    func drawItensMenu() {
        
        var buttonSize:CGFloat = 50
        var buttonsY:CGFloat = buttonSize/2 + 10
        
        addTreeButton = SKSpriteNode(imageNamed: "RectPurple")
        addTreeButton?.size = CGSizeMake(buttonSize, buttonSize)
        addTreeButton?.position = CGPointMake(addTreeButton!.size.width/2, buttonsY)
        addTreeButton?.name = "AddTree"
        self.addChild(addTreeButton!)
        
        addHerbivoreButton = SKSpriteNode(imageNamed: "RectOrange")
        addHerbivoreButton?.size = CGSizeMake(buttonSize, buttonSize)
        addHerbivoreButton?.position = CGPointMake(addHerbivoreButton!.size.width/2 + addHerbivoreButton!.size.width, buttonsY)
        addHerbivoreButton?.name = "AddHerb"
        self.addChild(addHerbivoreButton!)
        
        addCarnivoreButton = SKSpriteNode(imageNamed: "RectPurple")
        addCarnivoreButton?.size = CGSizeMake(buttonSize, buttonSize)
        addCarnivoreButton?.position = CGPointMake(addCarnivoreButton!.size.width/2 + 2*addCarnivoreButton!.size.width, buttonsY)
        addCarnivoreButton?.name = "AddCarn"
        self.addChild(addCarnivoreButton!)
        
    }
    
    func swipeLeft() {
        //Decrease tickTime and animate
    }
    
    func swipeRight() {
        //Increase tickTime and animate (if increase too much, pause game)
    }
    
    override func touchesBegan(touches: Set<NSObject>, withEvent event: UIEvent) {
        /* Called when a touch begins */
        
        for touch in (touches as! Set<UITouch>) {
            
            var name = nodeAtPoint(touch.locationInNode(self)).name
            
            if name == "AddTree" {
                spawnEntity("Tree")
            }
                
            if name == "AddHerb" {
                spawnEntity("Herbivore")
            }
            
            if name == "AddCarn" {
                spawnEntity("Carnivore")
            }
        }
    }
    
    override func touchesMoved(touches: Set<NSObject>, withEvent event: UIEvent) {
        
    }
    
    override func touchesEnded(touches: Set<NSObject>, withEvent event: UIEvent) {
        
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
        
        if(c1.name == "tree" && c2.name == "herbivore") {
            c1.animateToDie()
            c1.aboutToDelete = 1
            var new = c2.reproduce()
            creaturesArray.append(new)
            islandSprite.addChild(new)
        }
        if(c1.name == "herbivore" && c2.name == "tree") {
            c2.animateToDie()
            c2.aboutToDelete = 1
            var new = c1.reproduce()
            creaturesArray.append(new)
            islandSprite.addChild(new)
        }
        if(c1.name == "herbivore" && c2.name == "carnivore") {
            c1.animateToDie()
            c1.aboutToDelete = 1
            var new = c2.reproduce()
            creaturesArray.append(new)
            islandSprite.addChild(new)
        }
        if(c1.name == "carnivore" && c2.name == "herbivore") {
            c2.animateToDie()
            c2.aboutToDelete = 1
            var new = c1.reproduce()
            creaturesArray.append(new)
            islandSprite.addChild(new)
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
        
        if(type=="Tree") {
            var sprite = Tree(size: sizeOfSprites, rect: islandSprite.frame)
            creaturesArray.append(sprite as Lifeform)
            self.islandSprite.addChild(sprite)
        }
        if(type=="Herbivore") {
            var sprite = Herbivore(size: sizeOfSprites, rect: islandSprite.frame)
            creaturesArray.append(sprite as Lifeform)
            self.islandSprite.addChild(sprite)
        }
        if(type=="Carnivore") {
            var sprite = Carnivore(size: sizeOfSprites, rect: islandSprite.frame)
            creaturesArray.append(sprite as Lifeform)
            self.islandSprite.addChild(sprite)
        }
        if(type=="Building") {
            
        }
    }
    
    func calculatePollution() {
        
        var pollution = 0
        
        for i in buildingsArray {
            pollution += i.pollutionRate
        }
        
        for i in creaturesArray {
            pollution -= i.pollutionIncrement
        }
        
        //Show weather effects according to pollution here
        
    }
    
    override func update(currentTime: CFTimeInterval) {
        /* Called before each frame is rendered */
    }
    
}
