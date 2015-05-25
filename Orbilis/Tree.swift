//
//  Tree.swift
//  Orbilis
//
//  Created by Joao Nassar Galante Guedes on 25/05/15.
//  Copyright (c) 2015 Joao Nassar Galante Guedes. All rights reserved.
//

import SpriteKit

class Tree: Lifeform {
    
    init(size: CGFloat) {
        
        let texture = SKTexture(imageNamed: "Tree")
        let sizeWH = CGSize(width: size, height: size)
        
        super.init(texture: texture, color: nil, size: sizeWH)
        
        pollutionIncrement = -10
        pollutionLimit = 300
        reproductionRate = 0
        lifeTimeMax = 300
        organicProduction = 0
        cost = 100
        
        self.physicsBody = SKPhysicsBody(circleOfRadius: (size)/2)
        self.physicsBody?.dynamic = false
        self.physicsBody?.categoryBitMask = 1 << 1
        self.physicsBody?.contactTestBitMask = 0xFFFFFF
        
        self.name = "tree"
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
   
}
