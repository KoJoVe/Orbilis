//
//  Herbivore.swift
//  Orbilis
//
//  Created by Joao Nassar Galante Guedes on 25/05/15.
//  Copyright (c) 2015 Joao Nassar Galante Guedes. All rights reserved.
//

import SpriteKit

class Herbivore: Lifeform {
    
    var theSize: CGFloat = 0
    var theRect = CGRect()
    
    init(size: CGFloat, rect: CGRect) {
        
        let texture = SKTexture(imageNamed: "Herb")
        let sizeWH = CGSize(width: size, height: size)
        
        theSize = size
        theRect = rect
        
        super.init(texture: texture, color: nil, size: sizeWH)
        
        pollutionIncrement = 0
        pollutionLimit = 400
        reproductionRate = 0
        lifeTimeMax = 90
        organicProduction = 0
        
        self.position = randomPointInsideRect(rect)
        self.zPosition = 4
        
        self.name = "herbivore"
    }
    
    override func interact(lifeform: SKSpriteNode) -> Bool {
        
        if(lifeform.name == "tree" && fed == false) {
            var node = lifeform as! Lifeform
            node.animateToDie()
            fed = true
            node.aboutToDelete = 1
            return true
        }
        
        return false
    }
    
    override func reproduce() -> Lifeform? {
        var herbivore = Herbivore(size: theSize,rect: theRect)
        herbivore.position = self.position
        return herbivore as Lifeform
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
