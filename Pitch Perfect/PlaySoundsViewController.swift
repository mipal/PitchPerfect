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
        audioEngine.stop()
        audioEngine.reset()
        audioPlayer.rate = rate
        audioPlayer.currentTime = 0.0
        audioPlayer.play()
    }
    
    
    func playEngineWithEffect(effectNode: AVAudioNode) {
        audioPlayer.stop()
        audioEngine.stop()
        audioEngine.reset()
        
        var audioPlayerNode = AVAudioPlayerNode()
        audioEngine.attachNode(audioPlayerNode)
        
        // Attach the audio effect node corresponding to the user selected effect
        audioEngine.attachNode(effectNode)
        
        // Connect Player --> AudioEffect
        audioEngine.connect(audioPlayerNode, to: effectNode, format: nil)
        // Connect AudioEffect --> Output
        audioEngine.connect(effectNode, to: audioEngine.outputNode, format: nil)
        
        audioPlayerNode.scheduleFile(audioFile, atTime: nil, completionHandler:nil)
        
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
        var changePitchEffect = AVAudioUnitTimePitch()
        changePitchEffect.pitch = 1000
        
        playEngineWithEffect(changePitchEffect)
    }
    
    @IBAction func pressedVader(sender: AnyObject) {
        var changePitchEffect = AVAudioUnitTimePitch()
        changePitchEffect.pitch = -1000
        
        playEngineWithEffect(changePitchEffect)
    }
    
    @IBAction func pressedStop(sender: AnyObject) {
        audioPlayer.stop()
        audioEngine.stop()
        audioEngine.reset()
    }
    
    @IBAction func pressedReverb(sender: AnyObject) {
        var reverbNode = AVAudioUnitReverb()
        reverbNode.loadFactoryPreset( AVAudioUnitReverbPreset.Cathedral)
        reverbNode.wetDryMix = 60
        
        playEngineWithEffect(reverbNode)
    }
    
    @IBAction func pressedEcho(sender: AnyObject) {
        var echoNode = AVAudioUnitDelay()
        echoNode.delayTime = NSTimeInterval(0.3)
        
        playEngineWithEffect(echoNode)
    }
    
}
