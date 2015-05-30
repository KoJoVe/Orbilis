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
        pollutionLimit = 40000
        reproductionRate = 0
        lifeTimeMax = 25
        organicProduction = 70
        
        self.position = randomPointInsideRect(rect)
        self.zPosition = 5
        
        self.name = "herbivore"
    }
    
    override func interact(lifeform: SKSpriteNode) -> Bool {
        
        //         node.aboutToDelete = 1
        //            node.animateToDie()
        
        var r = random(1...80)
        
        if(lifeform.name == "tree" && fed == false && r == 1) {
            var node = lifeform as! Lifeform
            if(node.eaten == false) {
                node.eaten = true
                fed = true
                return true
            } else {
                return false
            }
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
