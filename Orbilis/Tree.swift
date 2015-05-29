//
//  Tree.swift
//  Orbilis
//
//  Created by Joao Nassar Galante Guedes on 25/05/15.
//  Copyright (c) 2015 Joao Nassar Galante Guedes. All rights reserved.
//

import SpriteKit

class Tree: Lifeform {
    
    init(size: CGFloat, rect: CGRect) {
        
        let texture = SKTexture(imageNamed: "Tree")
        let sizeWH = CGSize(width: size, height: size)
        
        super.init(texture: texture, color: nil, size: sizeWH)
        
        pollutionIncrement = -15
        pollutionLimit = 500
        reproductionRate = 0
        lifeTimeMax = 300
        organicProduction = 0
        
        self.position = randomPointInsideRect(rect)
        self.zPosition = 5
        
        self.name = "tree"
    }
    
    override func move(rect: CGRect, time: Double) {
        
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
   
}
