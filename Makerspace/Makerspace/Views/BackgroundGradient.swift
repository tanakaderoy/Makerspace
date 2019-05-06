//
//  BackgroundGradient.swift
//  Makerspace
//
//  Created by Rob McMahon on 5/6/19.
//  Copyright © 2019 Rob McMahon. All rights reserved.
//

import Foundation
import UIKit

@IBDesignable
class BackgroundGradient: UIView {
    
    @IBInspectable var firstColor: UIColor = #colorLiteral(red: 1, green: 0.1491314173, blue: 0, alpha: 0.9609925176) {
        didSet {
            
        }
    }
    @IBInspectable var secondColor: UIColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0) {
        didSet {
            
        }
    }
    @IBInspectable var startPoint: CGPoint = CGPoint(x: 0, y: 0){
        didSet {
            
        }
    }
    @IBInspectable var endPoint: CGPoint = CGPoint(x: 0, y: 0) {
        didSet {
            
        }
    }
    @IBInspectable var cornerRadius: CGFloat = 0 {
        didSet {
            
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupViews()
    }
    
    override func prepareForInterfaceBuilder() {
        setupViews()
    }
    
    
    func setupViews() {
        let gradientLayer = CAGradientLayer()
        gradientLayer.colors = [firstColor.cgColor, secondColor.cgColor]
        gradientLayer.startPoint = startPoint
        gradientLayer.endPoint = endPoint
        gradientLayer.frame = self.bounds
        self.layer.addSublayer(gradientLayer)
        self.layer.cornerRadius = cornerRadius
    }
} //end class
