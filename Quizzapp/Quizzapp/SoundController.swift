//
//  SoundController.swift
//  Quizzapp
//
//  Created by Ethan Hess on 6/27/16.
//  Copyright © 2016 Ethan Hess. All rights reserved.
//

import UIKit
import AVFoundation

class SoundController: NSObject {
    
    var player : AVAudioPlayer!
    
    static let sharedManager = SoundController ()
    
    func playAudioFileAtURL(url: NSURL) {
        
        if NSUserDefaults.standardUserDefaults().boolForKey(soundKey) {
        
        try! player = AVAudioPlayer(contentsOfURL: url)
        player.numberOfLoops = 0
        player.play()
            
        } else {
            
            return
        }
    }

}
