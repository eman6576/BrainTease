//
//  GameResultsView.swift
//  BrainTease
//
//  Created by Emanuel  Guerrero on 5/23/16.
//  Copyright © 2016 Project Omicron. All rights reserved.
//

import UIKit

class GameResultsView: UIView {
    @IBOutlet weak var numberOfCorrectLabel: UILabel!
    @IBOutlet weak var numberOfIncorrectLabel: UILabel!
    
    override func awakeFromNib() {
        setUpView()
    }
    
    @IBAction func restartButtonTapped(sender: CustomButton) {
        NSNotificationCenter.defaultCenter().postNotificationName("restartButtonTapped", object: nil)
    }
    
    func setUpView() {
        self.layer.cornerRadius = 3.0
        self.layer.shadowOpacity = 0.8
        self.layer.shadowRadius = 5.0
        self.layer.shadowOffset = CGSizeMake(0.0, 2.0)
        self.layer.shadowColor = UIColor(red: 157.0 / 255.0, green: 157.0 / 255.0, blue: 157.0 / 255.0, alpha: 1.0).CGColor
        self.setNeedsLayout()
    }
    
    func configureResults(numberOfCorrectChoices: Int, numberOfIncorrectChoices: Int) {
        numberOfCorrectLabel.text = "\(numberOfCorrectChoices)"
        numberOfIncorrectLabel.text = "\(numberOfIncorrectChoices)"
    }
}