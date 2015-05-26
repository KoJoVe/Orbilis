//
//  Lifeforms.swift
//  Orbilis
//
//  Created by Joao Nassar Galante Guedes on 25/05/15.
//  Copyright (c) 2015 Joao Nassar Galante Guedes. All rights reserved.
//

import Foundation
import SpriteKit

class Lifeform: SKSpriteNode {
    
    var pollutionIncrement = 0
    var pollutionLimit = 0
    var reproductionRate = 0
    var lifeTimeMax = 15
    var organicProduction = 0
    var cost = 0
    
    var aboutToDelete = 0 //Prevent Flying Memory
    
    var hungerCooldown = 0
    var lifeTime = 0
    
    func move(rect: CGRect, time: Double) {
        //Move this lifeform to a random position in rect, in time.
        var action = SKAction.moveTo(randomPointInsideRect(rect), duration: time)
        self.runAction(action)
        lifeTime++
    }
    
    func chanceToDie(pollution: Int) {
        //Calculate a percentage based on pullution limit. If certain percentage, the lifeform die.
    }
    
    func eat(lifeform: Lifeform) -> Bool {
        if(hungerCooldown <= 0) {
            hungerCooldown = 10
            return true
        }
        return false
    }
    
    func animateToDie() {
        var action = SKAction.fadeAlphaTo(0, duration: 0.1)
        self.runAction(action)
    }
    
    func die() {
        self.removeFromParent()
    }
    
    func reproduce() -> Lifeform {
        //Subclass only
        return Lifeform()
    }
    
    func randomPointInsideRect(rect: CGRect) -> CGPoint {
        var x = CGFloat(random(Int(-rect.size.width/2)...Int(rect.size.width/2)))
        var y = CGFloat(random(Int(-rect.size.height/2)...Int(rect.size.height/2)))
        return CGPointMake(x, y)
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
}
