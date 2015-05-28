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
        
        return nil
    }
    
    class func getActionCost(type: String) -> Int {
        
        return 100
        
    }
    
}
