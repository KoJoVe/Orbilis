//
//  AddCreaturesMenu.swift
//  Orbilis
//
//  Created by Joao Nassar Galante Guedes on 26/05/15.
//  Copyright (c) 2015 Joao Nassar Galante Guedes. All rights reserved.
//

import SpriteKit

class Actions: NSObject {
    
    class func getActionsArray() -> Array<String> {
        
        var array:Array<String> = []
        
        array.append("AddTree")
        array.append("AddHerb")
        array.append("AddCarn")
        array.append("RemoveFactory")
        
        return array
        
    }
    
    class func getActionIndex(type: String) -> Int {
        
        var array = getActionsArray()
        
        for var i = 0; i<array.count; i++ {
            if(array[i] == type) {
                return i
            }
        }
        
        return 0
    }
    
    class func executeAction(type: String, size: CGFloat, rect: CGRect) -> (node: AnyObject?,type: String) {
      
        if(type=="AddTree") {
            var sprite = Tree(size: size, rect: rect)
            return (sprite as AnyObject,"Lifeform")
        }
        if(type=="AddHerb") {
            var sprite = Herbivore(size: size, rect: rect)
            return (sprite as AnyObject,"Lifeform")
        }
        if(type=="AddCarn") {
            var sprite = Carnivore(size: size, rect: rect)
            return (sprite as AnyObject,"Lifeform")
        }
        if(type=="AddFactory") {
            var sprite = Building(size: size, rect: rect)
            return (sprite as AnyObject,"Building")
        }
        if(type=="RemoveFactory") {
            return ("Removed", "RemoveFactory")
        }
        
        return (nil,"Nil")
    }
    
    class func getActionButton(type: String) -> SKSpriteNode? {
        
        if(type=="AddTree") {
            var sprite = SKSpriteNode(imageNamed: "TreeButton")
            return sprite
        }
        if(type=="AddHerb") {
            var sprite = SKSpriteNode(imageNamed: "HerbButton")
            return sprite
        }
        if(type=="AddCarn") {
            var sprite = SKSpriteNode(imageNamed: "CarnButton")
            return sprite
        }
        if(type=="RemoveFactory") {
            var sprite = SKSpriteNode(imageNamed: "FacButton")
            return sprite
        }
        
        return nil
    }
    
    class func getActionText(type: String) -> String? {
        
        if(type=="AddTree") {
            return "Add Tree"
        }
        if(type=="AddHerb") {
            return "Add Herbivore"
        }
        if(type=="AddCarn") {
            return "Add Carnivore"
        }
        if(type=="RemoveFactory") {
            return "Remove Factory"
        }
        
        if(type=="1x") {
            return "Normal Speed"
        }
        if(type=="2x") {
            return "Super Speed"
        }
        if(type=="3x") {
            return "Hyper Speed"
        }
        
        return nil
        
    }
    
    class func getActionDescriptor(type: String) -> SKTexture? {
        
        if(type=="AddTree") {
            var sprite = SKTexture(imageNamed: "TreeButton")
            return sprite
        }
        if(type=="AddHerb") {
            var sprite = SKTexture(imageNamed: "HerbButton")
            return sprite
        }
        if(type=="AddCarn") {
            var sprite = SKTexture(imageNamed: "CarnButton")
            return sprite
        }
        if(type=="RemoveFactory") {
            var sprite = SKTexture(imageNamed: "FacButton")
            return sprite
        }
        
        if(type=="1x") {
            var sprite = SKTexture(imageNamed: "Fast1x")
            return sprite
        }
        if(type=="2x") {
            var sprite = SKTexture(imageNamed: "Fast2x")
            return sprite
        }
        if(type=="3x") {
            var sprite = SKTexture(imageNamed: "Fast3x")
            return sprite
        }
        
        return nil
    }
    
    class func getActionCost(type: String, timesExecuted: Int) -> Int {
        
        if(type=="AddTree") {
            return 50//Int(100 * pow(9/8,Double(timesExecuted)))
        }
        if(type=="AddHerb") {
            return 75
        }
        if(type=="AddCarn") {
            return 100
        }
        if(type=="RemoveFactory") {
            return Int(50 * pow(51/50,Double(timesExecuted)))
        }
        
        return 0
    }
}
