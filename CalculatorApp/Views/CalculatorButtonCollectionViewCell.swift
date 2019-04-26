//
//  CalculatorButtonCollectionViewCell.swift
//  CalculatorApp
//
//  Created by Lukas Carvajal on 26.04.19.
//  Copyright © 2019 AppsByLukas. All rights reserved.
//

import UIKit

class CalculatorButtonCollectionViewCell: UICollectionViewCell {
    private let button: UIButton = {
        let button = UIButton()
        button.clipsToBounds = true
        button.setTitleColor(.white, for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 40, weight: .regular)
        return button
    }()
    
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
        
        addSubview(button)
        button.layer.cornerRadius = (frame.width - 10) / 2
        
        configureConstraints()
    }
    
    // MARK: - Styling
    
    internal func styleLight(_ buttonCharacter: String) {
        button.setTitle(buttonCharacter, for: .normal)
        button.backgroundColor = .lightGray
    }
    
    internal func styleBright(_ buttonCharacter: String) {
        button.setTitle(buttonCharacter, for: .normal)
        button.backgroundColor = .orange
    }
    
    internal func styleDark(_ buttonCharacter: String) {
        button.setTitle(buttonCharacter, for: .normal)
        button.backgroundColor = .darkGray
    }
    
    // MARK: - Constraints
    
    private func configureConstraints() {
        button.translatesAutoresizingMaskIntoConstraints = false
        
        let views: [String: Any] = [
            "button": button
        ]
        var constraints: [NSLayoutConstraint] = []
        
        // Centers orange background in cell
        
        let buttonBackgroundHorizontalConstraint = NSLayoutConstraint.constraints(
            withVisualFormat: "|-5-[button]-5-|",
            options: [],
            metrics: nil,
            views: views)
        constraints += buttonBackgroundHorizontalConstraint
        
        let buttonBackgroundVerticalConstraint = NSLayoutConstraint.constraints(
            withVisualFormat: "V:|-5-[button]-5-|",
            options: [],
            metrics: nil,
            views: views)
        constraints += buttonBackgroundVerticalConstraint
        
        NSLayoutConstraint.activate(constraints)
    }
}
