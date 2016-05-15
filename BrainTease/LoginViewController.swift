//
//  ViewController.swift
//  BrainTease
//
//  Created by Emanuel  Guerrero on 5/14/16.
//  Copyright © 2016 Project Omicron. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController {
    @IBOutlet weak var emailCenterConstraint: NSLayoutConstraint!
    @IBOutlet weak var passwordCenterConstraint: NSLayoutConstraint!
    @IBOutlet weak var loginButtonCenterConstraint: NSLayoutConstraint!
    
    var animationEngine: AnimationEngine!

    override func viewDidLoad() {
        super.viewDidLoad()
        self.animationEngine = AnimationEngine(constraints: [emailCenterConstraint, passwordCenterConstraint, loginButtonCenterConstraint])
    }
    
    override func viewDidAppear(animated: Bool) {
        self.animationEngine.animateOnScreen(1)
    }
}

