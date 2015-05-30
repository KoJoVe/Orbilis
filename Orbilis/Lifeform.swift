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
    
    var fed = false
    var pollutionIncrement = 0
    var pollutionLimit = 0
    var reproductionRate = 0
    var lifeTimeMax = 15
    var organicProduction = 0
    var hungerCooldownRate = 10
    var organicProductionP = 0
    var eaten = false
    
    var aboutToDelete = 0 //Prevent Flying Memory
    
    var hungerCooldown = 0
    var lifeTime = 0
    
    func move(rect: CGRect, time: Double) {
        //Move this lifeform to a random position in rect, in time.
        var action = SKAction.moveTo(randomPointInsideRect(rect), duration: time)
        self.runAction(action)
        lifeTime++
    }
    
    func chanceToDie(pollution: Int) -> Bool {
        if(pollution >= pollutionLimit) {
            var r = random(1...4)
            if(r<=1) {
                return true
            }
        }
        return false
    }
    
    func interact(lifeform: SKSpriteNode) -> Bool {
        return false
        //Subclass only
    }
    
    func eat(lifeform: Lifeform) -> Bool {
        if(hungerCooldown <= 0) {
            hungerCooldown = hungerCooldownRate
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
    
    func reproduce() -> Lifeform? {
        //Subclass only
        return Lifeform()
    }
    
    func randomPointInsideRect(rect: CGRect) -> CGPoint {
        
        var angle = Double(-1*random(0...100))/100
        var radius = CGFloat(random(0...Int(rect.size.width/2)))
        
        var point = rotatePoint(0, cY: -rect.size.height/2, angle: Float(angle*M_PI), pX: (-radius), pY: -rect.size.height/2)
        
        return point
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
    
    func rotatePoint(cX: CGFloat,cY: CGFloat,angle: Float,pX: CGFloat, pY: CGFloat) -> CGPoint {
        
        var s:CGFloat = CGFloat(sin(angle))
        var c:CGFloat = CGFloat(cos(angle))
        
        var newpX = pX
        var newpY = pY
        
        newpX = pX - cX
        newpY = pY - cY
        
        var xnew:CGFloat = newpX * c - newpY * s
        var ynew:CGFloat = newpX * s + newpY * c
        
        newpX = xnew + cX
        newpY = ynew + cY
        
        return CGPointMake(newpX, newpY)
        
    }
}
