//
//  UserData.swift
//  Orbilis
//
//  Created by Joao Nassar Galante Guedes on 25/05/15.
//  Copyright (c) 2015 Joao Nassar Galante Guedes. All rights reserved.
//

import Foundation

class UserData: NSObject {
    
    
    class func initializePlist() {
        
        var pathAux = NSSearchPathForDirectoriesInDomains(.DocumentDirectory, .UserDomainMask, true)[0] as! String
        var path = pathAux.stringByAppendingPathComponent("tantoFaz.plist")
        var fileManager = NSFileManager.defaultManager()
        if (!(fileManager.fileExistsAtPath(path))) {
            
            var bundle : NSString! = NSBundle.mainBundle().pathForResource("tantoFaz", ofType: "plist")
            fileManager.copyItemAtPath(bundle as String, toPath: path, error:nil)
        }
        
    }
    
    class func isFirstTime() -> Int {
        
        var pathAux = NSSearchPathForDirectoriesInDomains(.DocumentDirectory, .UserDomainMask, true)[0] as! String
        var path = pathAux.stringByAppendingPathComponent("tantoFaz.plist")
        
        var fileManager = NSFileManager.defaultManager()
        if (!(fileManager.fileExistsAtPath(path))) {
            
            var bundle : NSString! = NSBundle.mainBundle().pathForResource("tantoFaz", ofType: "plist")
            fileManager.copyItemAtPath(bundle as String, toPath: path, error:nil)
            
        }
        
        let contents: NSDictionary! = NSDictionary(contentsOfFile: path as String)
        var first = contents.objectForKey("FirstTime") as! Int
        
        return first
    }
    
    class func setAlreadyUser(n: Int) {
        
        var pathAux = NSSearchPathForDirectoriesInDomains(.DocumentDirectory, .UserDomainMask, true)[0] as! String
        var path = pathAux.stringByAppendingPathComponent("tantoFaz.plist")
        
        var fileManager = NSFileManager.defaultManager()
        if (!(fileManager.fileExistsAtPath(path))) {
            
            var bundle : NSString! = NSBundle.mainBundle().pathForResource("tantoFaz", ofType: "plist")
            fileManager.copyItemAtPath(bundle as String, toPath: path, error:nil)
            
        }
        
        let contents: NSMutableDictionary! = NSMutableDictionary(contentsOfFile: path as String)
        
        contents.setObject(n, forKey: "FirstTime")
        contents.writeToFile(path, atomically: false)
    }
    
    
    class func setUserRecord(record: Int) {
        
        var pathAux = NSSearchPathForDirectoriesInDomains(.DocumentDirectory, .UserDomainMask, true)[0] as! String
        var path = pathAux.stringByAppendingPathComponent("tantoFaz.plist")
        
        var fileManager = NSFileManager.defaultManager()
        if (!(fileManager.fileExistsAtPath(path))) {
            
            var bundle : NSString! = NSBundle.mainBundle().pathForResource("tantoFaz", ofType: "plist")
            fileManager.copyItemAtPath(bundle as String, toPath: path, error:nil)
            
        }
        
        let contents: NSMutableDictionary! = NSMutableDictionary(contentsOfFile: path as String)
        
        contents.setObject(record, forKey: "UserRecord")
        contents.writeToFile(path, atomically: false)
        
    }
    
    class func getUserRecord() -> Int {
        
        var pathAux = NSSearchPathForDirectoriesInDomains(.DocumentDirectory, .UserDomainMask, true)[0] as! String
        var path = pathAux.stringByAppendingPathComponent("tantoFaz.plist")
        
        var fileManager = NSFileManager.defaultManager()
        if (!(fileManager.fileExistsAtPath(path))) {
            
            var bundle : NSString! = NSBundle.mainBundle().pathForResource("tantoFaz", ofType: "plist")
            fileManager.copyItemAtPath(bundle as String, toPath: path, error:nil)
            
        }
        
        let contents: NSDictionary! = NSDictionary(contentsOfFile: path as String)
        var record = contents.objectForKey("UserRecord") as! Int
        
        
        return record
    }
   
}
