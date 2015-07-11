//
//  RecordSoundsViewController.swift
//  Pitch Perfect
//
//  Created by Michael Palka on Jul/9/2015.
//  Copyright (c) 2015 Cyanshift Apps AB. All rights reserved.
//

import UIKit

class RecordSoundsViewController: UIViewController {

    @IBOutlet weak var recordingLabel: UILabel!
    @IBOutlet weak var stopButton: UIButton!
    
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

    @IBAction func recordAudio(sender: UIButton) {
        recordingLabel.hidden = false
        //TODO: Record the user's coice
        stopButton.hidden = false
        
    }
    
    @IBAction func pressedStopButton(sender: AnyObject) {
        recordingLabel.hidden = true
    }
    
}

