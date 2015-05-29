//
//  Buildings.swift
//  Orbilis
//
//  Created by Joao Nassar Galante Guedes on 25/05/15.
//  Copyright (c) 2015 Joao Nassar Galante Guedes. All rights reserved.
//

import SpriteKit

class Building: SKSpriteNode {
    
    var pollutionRate = 10
    
    init(size: CGFloat, rect: CGRect) {
        
        let texture = SKTexture(imageNamed: "Factory")
        let sizeWH = CGSize(width: size, height: size)
        
        super.init(texture: texture, color: nil, size: sizeWH)
        
        self.position = randomPointInsideRect(rect)
        self.zPosition = 4
        
        self.name = "building"
    }
    
    func destroy() {
        var action = SKAction.fadeAlphaTo(0, duration: 0.1)
        self.runAction(action)
        self.removeFromParent()
    }
    
    func randomPointInsideRect(rect: CGRect) -> CGPoint {
        
        var angle = Double(-1*random(0...100))/100
        var radius = CGFloat(random(0...Int(1000*rect.size.width/2)))/1000
        
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
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
   
}
