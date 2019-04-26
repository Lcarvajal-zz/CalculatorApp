//
//  ViewController.swift
//  CalculatorApp
//
//  Created by Lukas Carvajal on 25.04.19.
//  Copyright © 2019 AppsByLukas. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    private let outputLabel =  NumberOutputLabel()
    
    private let buttonHolderView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        return view
    }()
    
    private var calculator = Calculator()
    
    override func loadView() {
        super.loadView()
        view.backgroundColor = .black

        view.addSubview(outputLabel)
        view.addSubview(buttonHolderView)
        
        configureConstraints()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    // MARK: - Constraints
    
    private func configureConstraints() {
        outputLabel.translatesAutoresizingMaskIntoConstraints = false
        buttonHolderView.translatesAutoresizingMaskIntoConstraints = false
        
        let views: [String: Any] = [
            "outputLabel": outputLabel,
            "buttonHolderView": buttonHolderView
        ]
        var constraints: [NSLayoutConstraint] = []
        
        let outputLabelHorizontalConstraints = NSLayoutConstraint.constraints(
            withVisualFormat: "|-24-[outputLabel]-24-|",
            options: [.alignAllTop],
            metrics: nil,
            views: views)
        constraints += outputLabelHorizontalConstraints
        
        let outputLabelVerticalConstraints = NSLayoutConstraint.constraints(
            withVisualFormat: "V:|-200-[outputLabel][buttonHolderView]-0-|",
            options: [],
            metrics: nil,
            views: views)
        constraints += outputLabelVerticalConstraints
        
        let buttonHolderViewHorizontalConstraings = NSLayoutConstraint.constraints(
            withVisualFormat: "|-16-[buttonHolderView]-16-|",
            options: [],
            metrics: nil,
            views: views)
        constraints += buttonHolderViewHorizontalConstraings
        
        NSLayoutConstraint.activate(constraints)
    }

}

