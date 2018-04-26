//
//  ViewController.swift
//  BullEye
//
//  Created by Khristina Sheer on 3/10/18.
//  Copyright © 2018 Khristina Sheer. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    var currentValue = 0
    @IBOutlet weak var slider: UISlider!
    var targetValue = 0
    @IBOutlet weak var targetLabel: UILabel!
    var score = 0
    @IBOutlet weak var scoreLabel: UILabel!
    var round = 0
    @IBOutlet weak var roundLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        currentValue = lroundf(slider.value)
        targetValue = Int(arc4random_uniform(101))
        startOver()
        
        let thumbImageNormal = #imageLiteral(resourceName: "SliderThumb-Normal") //UIImage(named: "SliderThumb-Normal")
        slider.setThumbImage(thumbImageNormal, for: .normal)
        
        let thumbImageHighlighted = #imageLiteral(resourceName: "SliderThumb-Highlighted") //UIImage(named: "SliderThumb-Highlighted")
        slider.setThumbImage(thumbImageHighlighted, for: .highlighted)
        
        let insets = UIEdgeInsets(top: 0, left: 14, bottom: 0, right: 14)
        
        let trackLeftImage = #imageLiteral(resourceName: "SliderTrackLeft") //UIImage(named: "SliderTrackLeft")
        let trackLeftResizable = trackLeftImage.resizableImage(withCapInsets: insets)
        slider.setMinimumTrackImage(trackLeftResizable, for: .normal)
        
        let trackRigthImage = #imageLiteral(resourceName: "SliderTrackRight") //UIImage(named: "SliderTrackRight")
        let trackRigthResizable = trackRigthImage.resizableImage(withCapInsets: insets)
        slider.setMaximumTrackImage(trackRigthResizable, for: .normal)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func updateLabel() {
        targetLabel.text = String(targetValue)
        scoreLabel.text = String(score)
        roundLabel.text = String(round)
    }

    func startNewRound() {
        targetValue = Int(arc4random_uniform(101))
        currentValue = 50
        slider.value = Float(currentValue)
        round += 1
        updateLabel()
    }
    
    @IBAction func startOver() {
        score = 0
        round = 0
        startNewRound()
    }
    
    @IBAction func sliderMoved(_ slider: UISlider) {
        print("Value of the slider is now: \(slider.value)")
        currentValue = lroundf(slider.value)
    }
    
    @IBAction func showAlert() {
        
        let difference = abs(targetValue - currentValue)
        var points = 100 - difference
        
        let title: String
        if difference == 0 {
            title = "Perfect!"
//            points = 100
        } else if difference < 5 {
            title = "You almost had it!"
            points = 50
//            if difference == 1 {
//                points += 50
//            }
        } else if difference < 20 {
            title = "Pretty good!"
            points = 0
        } else {
            points = 0
            title = "Not even close..."
        }
        
        score += points
        
        let message = "You selected number \(currentValue)" +
        "\nYou scored \(points) points"
        
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        
        // swift closure inside { }
        let action = UIAlertAction(title: "Awesome", style: .default, handler: {
            action in
            self.startNewRound()
        })
        
        alert.addAction(action)
        
        present(alert, animated: true, completion: nil)
    }
    
}

