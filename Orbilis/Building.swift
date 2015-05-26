//
//  Buildings.swift
//  Orbilis
//
//  Created by Joao Nassar Galante Guedes on 25/05/15.
//  Copyright (c) 2015 Joao Nassar Galante Guedes. All rights reserved.
//

import SpriteKit

class Building: SKSpriteNode {
    
    var pollutionRate = 100
    
    init(size: CGFloat, rect: CGRect) {
        
        let texture = SKTexture(imageNamed: "Tree")
        let sizeWH = CGSize(width: size, height: size)
        
        super.init(texture: texture, color: nil, size: sizeWH)
        
        self.physicsBody = SKPhysicsBody(circleOfRadius: (size)/2)
        self.physicsBody?.dynamic = false
        self.physicsBody?.categoryBitMask = 1 << 0
        self.physicsBody?.contactTestBitMask = 0xFFFFFF
        
        self.name = "building"
    }
    
    func destroy() {
        //Animate and remove from parent.
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
   
}
