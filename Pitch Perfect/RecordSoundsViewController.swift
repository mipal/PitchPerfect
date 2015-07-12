//
//  RecordSoundsViewController.swift
//  Pitch Perfect
//
//  Created by Michael Palka on Jul/9/2015.
//  Copyright (c) 2015 Cyanshift Apps AB. All rights reserved.
//

import UIKit
import AVFoundation

class RecordSoundsViewController: UIViewController, AVAudioRecorderDelegate {

    @IBOutlet weak var recordingLabel: UILabel!
    @IBOutlet weak var stopButton: UIButton!
    @IBOutlet weak var recordButton: UIButton!
    
    var audioRecorder:AVAudioRecorder!
    var recorderAudio: RecorderAudio!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillAppear(animated: Bool) {
        stopButton.hidden = true
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "stopRecordingSegue" {
            let playSoundsVc:PlaySoundsViewController = segue.destinationViewController as! PlaySoundsViewController
            let data = sender as! RecorderAudio
            playSoundsVc.receivedAudio = data
            
        }
    }
    // MARK: - Actions

    @IBAction func recordAudio(sender: UIButton) {
        recordingLabel.text = "Recording"
        stopButton.hidden = false
        recordButton.enabled = false
        let dirPath = NSSearchPathForDirectoriesInDomains(.DocumentDirectory, .UserDomainMask, true)[0] as! String
        
//        let currentDateTime = NSDate()
//        let formatter = NSDateFormatter()
//        formatter.dateFormat = "ddMMyyy-HHmmss"
//        let recordingName = formatter.stringFromDate(currentDateTime) + ".wav"
        let recordingName = "my_audio.wav"
        
        let pathArray = [dirPath, recordingName]
        let filePath = NSURL.fileURLWithPathComponents(pathArray)
        println(filePath)
        
        var session = AVAudioSession.sharedInstance()
        session.setCategory(AVAudioSessionCategoryPlayAndRecord, error: nil)
        
        audioRecorder = AVAudioRecorder(URL: filePath, settings: nil, error: nil)
        audioRecorder.delegate = self
        audioRecorder.meteringEnabled = true
        audioRecorder.prepareToRecord()
        audioRecorder.record()
        
    }
    
    @IBAction func pressedStopButton(sender: AnyObject) {
        audioRecorder.stop()
        AVAudioSession.sharedInstance().setActive(false, error: nil)
        recordingLabel.text = "Tap to record"
        recordButton.enabled = true
    }
    
    // MARK: - AVAudioRecorderDelegate
    func audioRecorderDidFinishRecording(recorder: AVAudioRecorder!, successfully flag: Bool) {
        
        if(flag) {
            recorderAudio = RecorderAudio(filePath: recorder.url, title: recorder.url.lastPathComponent!)            
            performSegueWithIdentifier("stopRecordingSegue", sender: recorderAudio)
        }
    }
}

