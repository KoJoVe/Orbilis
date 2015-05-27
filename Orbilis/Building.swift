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
        
        let texture = SKTexture(imageNamed: "RectPurple")
        let sizeWH = CGSize(width: size, height: size)
        
        super.init(texture: texture, color: nil, size: sizeWH)
        
        self.position = randomPointInsideRect(rect)
        self.zPosition = 3
        
        self.name = "building"
    }
    
    func destroy() {
        var action = SKAction.fadeAlphaTo(0, duration: 0.1)
        self.runAction(action)
        self.removeFromParent()
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
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
   
}
