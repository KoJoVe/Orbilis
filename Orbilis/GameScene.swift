//
//  GameScene.swift
//  Orbilis
//
//  Created by Joao Nassar Galante Guedes on 23/05/15.
//  Copyright (c) 2015 Joao Nassar Galante Guedes. All rights reserved.
//

import SpriteKit

class GameScene: SKScene, SKPhysicsContactDelegate {
    
    var tickTime = 10.0
    var tickTimer = NSTimer()
    var audioManager = AudioManager()
    var islandRect = CGRect()
    
    var creaturesArray: Array<Lifeform> = []
    var buildingsArray: Array<Building> = []
    
    var pauseButton: SKSpriteNode?
    var addTreeButton: SKSpriteNode?
    var addHerbivoreButton: SKSpriteNode?
    var addCarnivoreButton: SKSpriteNode?
    var removeBuildingButton: SKSpriteNode?

    var organicMatterLabel: SKLabelNode?
    var presentTimeLabel: SKLabelNode?
    
    var presentTime = 0
    var pollution = 0
    var organicMatter = 0
    
    override func didMoveToView(view: SKView) {
        /* Setup your scene here */
        
        
       updateTick()
    }
    
    override func touchesBegan(touches: Set<NSObject>, withEvent event: UIEvent) {
        /* Called when a touch begins */
        

    }
    
    func didBeginContact(contact: SKPhysicsContact) {
        
        if((contact.bodyA.categoryBitMask == 1<<1) && (contact.bodyB.categoryBitMask == 1<<2)) {
            var nodeA = contact.bodyA.node! as! Lifeform
            var nodeB = contact.bodyB.node! as! Herbivore
            var eaten = nodeB.eat(nodeA)
            if(eaten == true) {
                spawnEntity("Herbivore")
            }
        }
        
        if((contact.bodyA.categoryBitMask == 1<<2) && (contact.bodyB.categoryBitMask == 1<<1)) {
            var nodeA = contact.bodyB.node! as! Lifeform
            var nodeB = contact.bodyA.node! as! Herbivore
            var eaten = nodeB.eat(nodeA)
            if(eaten == true) {
                spawnEntity("Herbivore")
            }
        }
        
        if((contact.bodyA.categoryBitMask == 1<<2) && (contact.bodyB.categoryBitMask == 1<<3)) {
            var nodeA = contact.bodyA.node! as! Lifeform
            var nodeB = contact.bodyB.node! as! Carnivore
            var eaten = nodeB.eat(nodeA)
            if(eaten == true) {
                spawnEntity("Carnivore")
            }
        }
        
        if((contact.bodyA.categoryBitMask == 1<<3) && (contact.bodyB.categoryBitMask == 1<<2)) {
            var nodeA = contact.bodyB.node! as! Lifeform
            var nodeB = contact.bodyA.node! as! Carnivore
            var eaten = nodeB.eat(nodeA)
            if(eaten == true) {
                spawnEntity("Carnivore")
            }
        }
        
    }
   
    func updateTick() {
        
        tickTimer = NSTimer.scheduledTimerWithTimeInterval(tickTime, target: self, selector: Selector("updateTick"), userInfo: nil, repeats: false)
    }
    
    func spawnEntity(type: String) {
        
        if(type=="Tree") {
            
        }
        if(type=="Herbivore") {
            
        }
        if(type=="Carnivore") {
            
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
        
    }
    
    func agePopulation() {
        
        for i in creaturesArray {
            i.lifeTime += 1
            if(i.lifeTime >= i.lifeTimeMax) {
                i.die()
            }
        }
        
    }
    
    func moveEntities() {
        
        for i in creaturesArray {
            i.move(islandRect,time: tickTime)
        }
    }
    
    override func update(currentTime: CFTimeInterval) {
        /* Called before each frame is rendered */
    }
    
}
