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
        
        let texture = SKTexture(imageNamed: "RectGreen")
        let sizeWH = CGSize(width: size, height: size)
        
        super.init(texture: texture, color: nil, size: sizeWH)
        
        pollutionIncrement = -10
        pollutionLimit = 300
        reproductionRate = 0
        lifeTimeMax = 300
        organicProduction = 0
        cost = 100
        
        self.position = randomPointInsideRect(rect)
        self.zPosition = 2
        
        self.name = "tree"
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
   
}
