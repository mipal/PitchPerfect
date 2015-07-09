//
//  ViewController.swift
//  Pitch Perfect
//
//  Created by Michael Palka on Jul/9/2015.
//  Copyright (c) 2015 Cyanshift Apps AB. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func recordAudio(sender: UIButton) {
        //TODO: Show text "recording in progress"
        //TODO: Record the user's coice
        println("pressed record button")
    }
}

