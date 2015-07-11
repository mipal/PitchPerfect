//
//  PlaySoundsViewController.swift
//  Pitch Perfect
//
//  Created by Michael Palka on Jul/11/2015.
//  Copyright (c) 2015 Cyanshift Apps AB. All rights reserved.
//

import UIKit
import AVFoundation

class PlaySoundsViewController: UIViewController {

    var audioPlayer:AVAudioPlayer!
    var receivedAudio: RecorderAudio!
    var audioEngine: AVAudioEngine!
    var audioFile:AVAudioFile!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
//        if var filePath = NSBundle.mainBundle().pathForResource("movie_quote", ofType: "mp3") {
//            var fileUrl = NSURL.fileURLWithPath(filePath)
//            audioPlayer = AVAudioPlayer(contentsOfURL: fileUrl, error: nil)
//            audioPlayer.enableRate = true
//        } else {
//            println("error locating file")
//        }
        
        audioPlayer = AVAudioPlayer(contentsOfURL: receivedAudio.filePathUrl, error: nil)
        audioPlayer.enableRate = true
        audioEngine = AVAudioEngine()
        audioFile = AVAudioFile(forReading: receivedAudio.filePathUrl, error: nil)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    //MARK: - Private
    func playAudioAtRate(rate: Float) {
        audioPlayer.stop()
        audioPlayer.rate = rate
        audioPlayer.currentTime = 0.0
        audioPlayer.play()
    }
    
    func playAudioWithPitch(rate: Float) {
        audioPlayer.stop()
        audioEngine.stop()
        audioEngine.reset()

        var audioPlayerNode = AVAudioPlayerNode()
        audioEngine.attachNode(audioPlayerNode)
        
        var changePitchEffect = AVAudioUnitTimePitch()
        changePitchEffect.pitch = rate
        audioEngine.attachNode(changePitchEffect)
        
        audioEngine.connect(audioPlayerNode, to: changePitchEffect, format: nil)
        audioEngine.connect(changePitchEffect, to: audioEngine.outputNode, format: nil)
        
        audioPlayerNode.scheduleFile(audioFile, atTime: nil, completionHandler: nil)
        audioEngine.startAndReturnError(nil)
        
        audioPlayerNode.play()
    }
    
    //MARK: - Actions
    @IBAction func pressedSlow(sender: AnyObject) {
        playAudioAtRate(0.5)
    }
    
    @IBAction func pressedFast(sender: AnyObject) {
        playAudioAtRate(2.0)
    }
    
    @IBAction func pressedChipmunk(sender: AnyObject) {
        playAudioWithPitch(1000)
    }
    
    @IBAction func pressedVader(sender: AnyObject) {
        playAudioWithPitch(-1000)
    }
    
    @IBAction func pressedStop(sender: AnyObject) {
        audioPlayer.stop()
    }
}
