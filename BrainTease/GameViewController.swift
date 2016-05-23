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
    @IBOutlet weak var timerLabel: UILabel!
    
    var currentCard: CardView!
    var gameResultsView: GameResultsView!
    var counter = 0
    var timer: NSTimer!
    var numberOfCorrectChoices = 0
    var numberOfIncorrectChoices = 0
    var currentCardString: String!
    var previousCardString: String!
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        currentCard = createCardFromNib()
        currentCard.center = AnimationEngine.screenCenterPosition
        self.view.addSubview(currentCard)
        
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(restartGame), name: "restartButtonTapped", object: nil)
    }
    
    // MARK: - IBActions
    @IBAction func yesButtonTapped(sender: CustomButton) {
        if sender.titleLabel?.text == "YES" {
            checkAnswer(sender)
        } else {
            titleLabel.text = "Does this card match the previous?"
            previousCardString = currentCard.currentShape
            startGame()
        }
        showNextCard()
    }
    
    @IBAction func noButtonTapped(sender: CustomButton) {
        checkAnswer(sender)
        showNextCard()
    }
    
    // MARK: - Helpers
    func checkAnswer(sender: CustomButton) {
        currentCardString = currentCard.currentShape
        if previousCardString == currentCardString {
            if sender.titleLabel?.text == "YES" {
                numberOfCorrectChoices += 1
            } else {
                numberOfIncorrectChoices += 1
            }
        } else {
            if sender.titleLabel?.text == "NO" {
                numberOfCorrectChoices += 1
            } else {
                numberOfIncorrectChoices += 1
            }
        }
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
            // Ignore
        }
    }
    
    func createCardFromNib() -> CardView? {
        return NSBundle.mainBundle().loadNibNamed("Card", owner: self, options: nil)[0] as? CardView
    }
    
    func createGameResultsViewFromNib() -> GameResultsView? {
        return NSBundle.mainBundle().loadNibNamed("GameResults", owner: self, options: nil)[0] as? GameResultsView
    }
    
    func updateTimer() {
        if counter >= 10 {
            timerLabel.text = "0:\(counter)"
            counter -= 1
        } else if counter <= 9 && counter > 0 {
            timerLabel.text = "0:0\(counter)"
            counter -= 1
        } else {
            timerLabel.text = "0:0\(counter)"
            timer.invalidate()
            yesButton.userInteractionEnabled = false
            noButton.userInteractionEnabled = false
            endGame()
        }
    }
    
    func endGame() {
        self.titleLabel.hidden = true
        self.titleLabel.text = "Remember this image"
        self.yesButton.hidden = true
        self.yesButton.setTitle("START", forState: .Normal)
        self.noButton.hidden = true
        
        guard let current = currentCard else { return }
        let cardToRemove = current
        currentCard = nil
        
        AnimationEngine.animateToPosition(cardToRemove, position: AnimationEngine.offScreenLeftPosition) { (animation: POPAnimation!, finished: Bool) in
            cardToRemove.removeFromSuperview()
        }
        
        gameResultsView = createGameResultsViewFromNib()
        gameResultsView.configureResults(numberOfCorrectChoices, numberOfIncorrectChoices: numberOfIncorrectChoices)
        gameResultsView.center = AnimationEngine.offScreenRightPosition
        self.view.addSubview(gameResultsView)
        
        AnimationEngine.animateToPosition(self.gameResultsView, position: AnimationEngine.screenCenterPosition) { (animation: POPAnimation!, finished: Bool) in
            // Ignore
        }
    }
    
    func startGame() {
        counter = 59
        timer = NSTimer.scheduledTimerWithTimeInterval(0.6, target: self, selector: #selector(updateTimer), userInfo: nil, repeats: true)
    }
    
    func restartGame() {
        AnimationEngine.animateToPosition(gameResultsView, position: AnimationEngine.offScreenLeftPosition) { (animation: POPAnimation!, finished: Bool) in
            self.gameResultsView.removeFromSuperview()
        }
        
        guard let next = createCardFromNib() else { return }
        next.center = AnimationEngine.offScreenRightPosition
        self.view.addSubview(next)
        currentCard = next
        
        AnimationEngine.animateToPosition(next, position: AnimationEngine.screenCenterPosition) { (animation: POPAnimation!, finished: Bool) in
            self.titleLabel.hidden = false
            self.yesButton.hidden = false
            self.yesButton.userInteractionEnabled = true
            self.noButton.userInteractionEnabled = true
            self.timerLabel.text = "1:00"
            self.numberOfCorrectChoices = 0
            self.numberOfIncorrectChoices = 0
        }
    }
}
