//
//  CalculatorButtonCollectionViewCell.swift
//  CalculatorApp
//
//  Created by Lukas Carvajal on 26.04.19.
//  Copyright © 2019 AppsByLukas. All rights reserved.
//

import UIKit

class CalculatorButtonCollectionViewCell: UICollectionViewCell {
    private let buttonBackgroundView: UIView = {
        let view = UIView()
        view.backgroundColor = .orange
        return view
    }()
    
    private let numberLabel: UILabel = {
        let label = UILabel()
        
        label.text = "0"
        label.textColor = .white
        label.textAlignment = .center
        
        label.font = UIFont.systemFont(ofSize: 40, weight: .semibold)
        label.adjustsFontSizeToFitWidth = true
        
        label.backgroundColor = .orange
        label.numberOfLines = 1
        
        return label
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
        
        addSubview(buttonBackgroundView)
        buttonBackgroundView.addSubview(numberLabel)
        
        configureConstraints()
    }
    
    // MARK: - Constraints
    
    private func configureConstraints() {
        buttonBackgroundView.translatesAutoresizingMaskIntoConstraints = false
        numberLabel.translatesAutoresizingMaskIntoConstraints = false
        
        let views: [String: Any] = [
            "buttonBackgroundView": buttonBackgroundView,
            "numberLabel": numberLabel
        ]
        var constraints: [NSLayoutConstraint] = []
        
        // Centers orange background in cell
        
        let buttonBackgroundHorizontalConstraint = NSLayoutConstraint.constraints(
            withVisualFormat: "|-5-[buttonBackgroundView]-5-|",
            options: [],
            metrics: nil,
            views: views)
        constraints += buttonBackgroundHorizontalConstraint
        
        let buttonBackgroundVerticalConstraint = NSLayoutConstraint.constraints(
            withVisualFormat: "V:|-5-[buttonBackgroundView]-5-|",
            options: [],
            metrics: nil,
            views: views)
        constraints += buttonBackgroundVerticalConstraint
        
        // Centers label for button number in orange background
        
        let numberLabelHorizontalConstraints = NSLayoutConstraint.constraints(
            withVisualFormat: "|-1-[numberLabel]-1-|",
            options: [],
            metrics: nil,
            views: views)
        constraints += numberLabelHorizontalConstraints
        
        let numberLabelVerticalConstraints = NSLayoutConstraint.constraints(
            withVisualFormat: "V:|-1-[numberLabel]-1-|",
            options: .alignAllCenterY,
            metrics: nil,
            views: views)
        constraints += numberLabelVerticalConstraints
        
        NSLayoutConstraint.activate(constraints)
    }
}