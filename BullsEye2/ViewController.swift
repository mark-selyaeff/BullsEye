//
//  ViewController.swift
//  BullsEye2
//
//  Created by Марк Селяев on 10.02.17.
//  Copyright © 2017 Марк Селяев. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    var currentValue = 0
    var targetValue = 0
    var score = 0
    var round = 0
    
    @IBOutlet weak var roundLabel: UILabel!
    @IBOutlet weak var scoreLabel: UILabel!
    @IBOutlet weak var targetLabel: UILabel!
    @IBOutlet weak var slider: UISlider!
    
    @IBAction func sliderMoved(_ sender: UISlider) {
        currentValue = lroundf(sender.value)
    }

    @IBAction func showAlert(_ sender: Any) {
        let difference = abs(targetValue - currentValue)
        var points = 100 - difference
        let title: String
        
        if difference == 0{
            title = "Perfect!"
            points += 100
        } else if difference < 5 {
            title = "You almost had it!"
            points += 50
        } else if difference < 10 {
            title = "Pretty good"
        } else {
            title = "Not even close..."
        }
        let message = "The value of slider is \(currentValue)\n The target value is \(targetValue) and you scored \(points) points"
        score += points
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let actionItem = UIAlertAction(title: "neOK", style: .default) { [weak self]
            action in
                self?.startNewRound()
                self?.updateLabels()
        }
        alertController.addAction(actionItem)
        present(alertController, animated: true, completion: nil)
        
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        startNewRound()
        updateLabels()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func startNewRound() {
        round += 1
        targetValue = Int(arc4random_uniform(100)) + 1
        currentValue = 50
        slider.value = Float(currentValue)
    }
    
    func updateLabels() {
        targetLabel.text = String(targetValue)
        scoreLabel.text = String(score)
        roundLabel.text = String(round)
    }
    
    func startNewGame() {
        score = 0
        round = 0
        startNewRound()
    }
    
    @IBAction func startOver(_ sender: Any) {
        startNewGame()
        updateLabels()
    }
}

