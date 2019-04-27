//
//  ViewController.swift
//  CalculatorApp
//
//  Created by Lukas Carvajal on 25.04.19.
//  Copyright © 2019 AppsByLukas. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    let buttonTexts = [
        "C", "+/-", "%", "÷",
        "7", "8", "9", "×",
        "4", "5", "6", "-",
        "1", "2", "3", "+",
        "0", "0", ",", "="
    ]
    
    private let outputLabel =  NumberOutputLabel()
    private var buttonsCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.minimumInteritemSpacing = 0
        layout.minimumLineSpacing = 0

        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.backgroundColor = .black
        collectionView.register(CalculatorButtonCollectionViewCell.self,
                                forCellWithReuseIdentifier: "Cell")
        return collectionView
    }()
    
    private var calculator = Calculator()
    
    override func loadView() {
        super.loadView()
        view.backgroundColor = .black

        view.addSubview(outputLabel)
        view.addSubview(buttonsCollectionView)
        
        
        buttonsCollectionView.delegate = self
        buttonsCollectionView.dataSource = self
        
        configureConstraints()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    // MARK: - Actions
    
    @objc internal func tapNumber(sender: UIButton) {
        guard let titleLabel = sender.titleLabel,
            let text = titleLabel.text,
            let number = Int(text) else {
            debugPrint("Attempting to tap button with no number set on calculator")
            return
        }
        
        if outputLabel.text == "" || outputLabel.text == "0" {
            outputLabel.text = text
        }
        else {
            // FIXME: Force unwrapping optional
            outputLabel.text! += "\(number)"
        }
    }
    
    @objc internal func tapOperator(sender: UIButton) {
        if let outputText = outputLabel.text,
            let outputNumber = Double(outputText) {
            outputLabel.text = calculator.calculateAndGetResult(selectedOperator: .add, selectedOperand: outputNumber)
        }
    }

    // MARK: - Constraints
    
    private func configureConstraints() {
        outputLabel.translatesAutoresizingMaskIntoConstraints = false
        buttonsCollectionView.translatesAutoresizingMaskIntoConstraints = false
        
        let views: [String: Any] = [
            "outputLabel": outputLabel,
            "buttonsCollectionView": buttonsCollectionView
        ]
        var constraints: [NSLayoutConstraint] = []
        
        // Horizontal constraints
        
        let outputLabelHorizontalConstraints = NSLayoutConstraint.constraints(
            withVisualFormat: "|-24-[outputLabel]-24-|",
            options: [.alignAllTop],
            metrics: nil,
            views: views)
        constraints += outputLabelHorizontalConstraints
        
        let buttonHolderViewHorizontalConstraings = NSLayoutConstraint.constraints(
            withVisualFormat: "|-16-[buttonsCollectionView]-16-|",
            options: [],
            metrics: nil,
            views: views)
        constraints += buttonHolderViewHorizontalConstraings
        
        // Vertical constraints
        
        let verticalConstraints = NSLayoutConstraint.constraints(
            withVisualFormat: "V:|-200-[outputLabel][buttonsCollectionView]-0-|",
            options: [],
            metrics: nil,
            views: views)
        constraints += verticalConstraints
        
        NSLayoutConstraint.activate(constraints)
    }
}

// MARK: - Collection view

extension ViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView,
                        numberOfItemsInSection section: Int) -> Int {
        return 20
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let calculatorButtonCell = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell",
                                                                      for: indexPath) as! CalculatorButtonCollectionViewCell
        
        switch indexPath.row {
        case 0..<3:
            calculatorButtonCell.styleDark(buttonTexts[indexPath.row])
        case 3, 7, 11, 15, 19:
            calculatorButtonCell.styleBright(buttonTexts[indexPath.row])
            calculatorButtonCell.button.addTarget(self,
                                                  action: #selector(ViewController.tapOperator(sender:)),
                                                  for: .touchUpInside)
        default:
            calculatorButtonCell.styleLight(buttonTexts[indexPath.row])
            calculatorButtonCell.button.addTarget(self,
                                                  action: #selector(ViewController.tapNumber(sender:)),
                                                  for: .touchUpInside)
        }
        
        return calculatorButtonCell
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        let oneFourthOfScreenWidth = collectionView.frame.width / 4
        
        let size = CGSize(width: oneFourthOfScreenWidth,
                          height: oneFourthOfScreenWidth)
        return size
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
}

