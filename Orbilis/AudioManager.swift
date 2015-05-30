//
//  AudioManager.swift
//  Orbilis
//
//  Created by Joao Nassar Galante Guedes on 25/05/15.
//  Copyright (c) 2015 Joao Nassar Galante Guedes. All rights reserved.
//

import AVFoundation

class AudioManager: NSObject {
    
    var music = AVAudioPlayer()
    var clickSound = AVAudioPlayer()
    var bipSound = AVAudioPlayer()
    var dieSound = AVAudioPlayer()
    var speedSound = AVAudioPlayer()
    var factorySound = AVAudioPlayer()
    var destroySound = AVAudioPlayer()
    
    override init() {
        
        var musicSound = NSURL(fileURLWithPath: NSBundle.mainBundle().pathForResource("Earth Prelude", ofType: "mp3")!)
        music = AVAudioPlayer(contentsOfURL: musicSound, error: nil)
        
        music.numberOfLoops = -1
        music.volume = 1
        music.prepareToPlay()
        
        var bip = NSURL(fileURLWithPath: NSBundle.mainBundle().pathForResource("Click", ofType: "wav")!)
        bipSound = AVAudioPlayer(contentsOfURL: bip, error: nil)
        
        bipSound.volume = 0.05
        bipSound.prepareToPlay()
        
        var click = NSURL(fileURLWithPath: NSBundle.mainBundle().pathForResource("Menu", ofType: "wav")!)
        clickSound = AVAudioPlayer(contentsOfURL: click, error: nil)
        
        clickSound.volume = 0.1
        clickSound.prepareToPlay()
        
    }
    
    func playClick() {
        clickSound.play()
    }
    
    func playBip() {
        bipSound.play()
    }
    
    func play() {
        if(!music.playing && UserData.getAudio()) {
            music.currentTime = 4
            music.play()
        }
    }
    
    func stop() {
        music.stop()
    }
   
}
