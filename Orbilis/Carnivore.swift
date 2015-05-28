//
//  Carnivore.swift
//  Orbilis
//
//  Created by Joao Nassar Galante Guedes on 25/05/15.
//  Copyright (c) 2015 Joao Nassar Galante Guedes. All rights reserved.
//

import SpriteKit

class Carnivore: Lifeform {
    
    var theSize: CGFloat = 0
    var theRect = CGRect()
    
    init(size: CGFloat, rect: CGRect) {
        
        let texture = SKTexture(imageNamed: "Carn")
        let sizeWH = CGSize(width: size, height: size)
        
        theSize = size
        theRect = rect
        
        super.init(texture: texture, color: nil, size: sizeWH)
        
        pollutionIncrement = -10
        pollutionLimit = 300
        reproductionRate = 0
        lifeTimeMax = 5
        organicProduction = 100
        cost = 100
        
        self.position = randomPointInsideRect(rect)
        self.zPosition = 4
        
        self.name = "carnivore"
    }
    
    override func reproduce() -> Lifeform? {
        var herbivore = Carnivore(size: theSize,rect: theRect)
        herbivore.position = self.position
        return herbivore as Lifeform
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
