//
//  CustomButton.swift
//  BrainTease
//
//  Created by Emanuel  Guerrero on 5/15/16.
//  Copyright © 2016 Project Omicron. All rights reserved.
//

import UIKit
import pop

@IBDesignable
class CustomButton: UIButton {
    @IBInspectable var cornerRadius: CGFloat = 3.0 {
        didSet {
            setUpView()
        }
    }
    @IBInspectable var fontColor: UIColor = UIColor.whiteColor() {
        didSet {
            self.tintColor = fontColor
        }
    }
    
    override func awakeFromNib() {
        setUpView()
    }
    
    override func prepareForInterfaceBuilder() {
        super.prepareForInterfaceBuilder()
        setUpView()
    }
    
    func setUpView() {
        self.layer.cornerRadius = cornerRadius
        self.addTarget(self, action: #selector(self.scaleToSmall), forControlEvents: .TouchDown)
        self.addTarget(self, action: #selector(self.scaleToSmall), forControlEvents: .TouchDragEnter)
        self.addTarget(self, action: #selector(self.scaleAnimation), forControlEvents: .TouchUpInside)
        self.addTarget(self, action: #selector(self.scaleToDefault), forControlEvents: .TouchDragExit)
    }
    
    func scaleToSmall() {
        let scaleAnimation = POPBasicAnimation(propertyNamed: kPOPLayerScaleXY)
        scaleAnimation.toValue = NSValue(CGSize: CGSizeMake(0.95, 0.95))
        self.layer.pop_addAnimation(scaleAnimation, forKey: "layerScaleSmallAnimation")
    }
    
    func scaleAnimation() {
        let scaleAnimation = POPSpringAnimation(propertyNamed: kPOPLayerScaleXY)
        scaleAnimation.velocity = NSValue(CGSize: CGSizeMake(3.0, 3.0))
        scaleAnimation.toValue = NSValue(CGSize: CGSizeMake(1.0, 1.0))
        scaleAnimation.springBounciness = 18
        self.layer.pop_addAnimation(scaleAnimation, forKey: "layerScaleSpringAnimation")
    }
    
    func scaleToDefault() {
        let scaleAnimation = POPBasicAnimation(propertyNamed: kPOPLayerScaleXY)
        scaleAnimation.toValue = NSValue(CGSize: CGSizeMake(1, 1))
        self.layer.pop_addAnimation(scaleAnimation, forKey: "layerScaleDefaultAnimation")
    }
}