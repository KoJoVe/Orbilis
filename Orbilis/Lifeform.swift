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
    
    var pollutionIncrement = 0
    var pollutionLimit = 0
    var reproductionRate = 0
    var lifeTimeMax = 0
    var organicProduction = 0
    var cost = 0
    
    var hungerCooldown = 0
    var lifeTime = 0
    
    func move(rect: CGRect, time: Double) {
        
    }
    
    func chanceToDie(pollution: Int) {
        
    }
    
    func eat(lifeform: Lifeform) -> Bool {
        return true
    }
    
    func die() {
        
    }
}
