//
//  StartScreenViewController.swift
//  Hanoi
//
//  Created by Matthew Irvine on 9/15/15.
//  Copyright © 2015 Matthew Irvine. All rights reserved.
//

import Foundation
import UIKit

class StartScreenViewController : UIViewController {
    static let GAME_SEGUE_IDENTIFIER = "SegueToGame"
    
    @IBOutlet weak var discSlider: UISlider!
    @IBOutlet weak var discNumberLabel: UILabel!
    @IBOutlet weak var playButton: UIButton!
    
    var numberOfDiscs = 4
    
    override func viewDidLoad() {
        super.viewDidLoad()
        discSlider.addTarget(self, action: "handleSliderChange", forControlEvents: UIControlEvents.ValueChanged)
    }
    
    func handleSliderChange() {
        self.numberOfDiscs = Int(round(discSlider.value))
        discNumberLabel.text = "Number of Discs: \(self.numberOfDiscs)"
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == StartScreenViewController.GAME_SEGUE_IDENTIFIER {
            let gvc = segue.destinationViewController as! GameViewController
            gvc.numberOfDiscs = self.numberOfDiscs
        }
    }
}