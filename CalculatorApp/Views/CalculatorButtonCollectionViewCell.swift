//
//  CalculatorButtonCollectionViewCell.swift
//  CalculatorApp
//
//  Created by Lukas Carvajal on 26.04.19.
//  Copyright © 2019 AppsByLukas. All rights reserved.
//

import UIKit

class CalculatorButtonCollectionViewCell: UICollectionViewCell {
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }
    
    private func commonInit() {
        backgroundColor = .black
        
        let button = UIView()
        button.backgroundColor = .orange
        addSubview(button)
        
        button.translatesAutoresizingMaskIntoConstraints = false
        
        let views: [String: Any] = [
            "button": button
        ]
        var constraints: [NSLayoutConstraint] = []
        
        let horizontalButtonConstraint = NSLayoutConstraint.constraints(
            withVisualFormat: "|-5-[button]-5-|",
            options: [],
            metrics: nil,
            views: views)
        constraints += horizontalButtonConstraint
        
        let verticalButtonConstraint = NSLayoutConstraint.constraints(
            withVisualFormat: "V:|-5-[button]-5-|",
            options: [],
            metrics: nil,
            views: views)
        constraints += verticalButtonConstraint
        
        
        NSLayoutConstraint.activate(constraints)
    }
}
