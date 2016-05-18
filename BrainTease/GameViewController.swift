//
//  GameViewController.swift
//  BrainTease
//
//  Created by Emanuel  Guerrero on 5/15/16.
//  Copyright © 2016 Project Omicron. All rights reserved.
//

import UIKit
import pop

class GameViewController: UIViewController {
    @IBOutlet weak var yesButton: CustomButton!
    @IBOutlet weak var noButton: CustomButton!
    @IBOutlet weak var titleLabel: UILabel!
    
    var currentCard: CardView!
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        currentCard = createCardFromNib()
        currentCard.center = AnimationEngine.screenCenterPosition
        self.view.addSubview(currentCard)
    }
    
    // MARK: - IBActions
    @IBAction func yesButtonTapped(sender: CustomButton) {
        if sender.titleLabel?.text == "YES" {
            checkAnswer()
        } else {
            titleLabel.text = "Does this card match the previous?"
        }
        showNextCard()
    }
    
    @IBAction func noButtonTapped(sender: CustomButton) {
        checkAnswer()
        showNextCard()
    }
    
    // MARK: - Helpers
    func checkAnswer() {
    }
    
    func showNextCard() {
        guard let current = currentCard else { return }
        let cardToRemove = current
        currentCard = nil
        
        AnimationEngine.animateToPosition(cardToRemove, position: AnimationEngine.offScreenLeftPosition) { (animation: POPAnimation!, finished: Bool) in
            cardToRemove.removeFromSuperview()
        }
        
        guard let next = createCardFromNib() else { return }
        next.center = AnimationEngine.offScreenRightPosition
        self.view.addSubview(next)
        currentCard = next
        
        if noButton.hidden {
            noButton.hidden = false
            yesButton.setTitle("YES", forState: .Normal)
        }
        
        AnimationEngine.animateToPosition(next, position: AnimationEngine.screenCenterPosition) { (animation: POPAnimation!, finished: Bool) in
            
        }
    }
    
    func createCardFromNib() -> CardView? {
        return NSBundle.mainBundle().loadNibNamed("Card", owner: self, options: nil)[0] as? CardView
    }
}
