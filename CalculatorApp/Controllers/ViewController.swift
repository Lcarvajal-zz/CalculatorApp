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
    
    var operands: [Double] = []
    var lastOperand: Double?
    var lastOperator: Operator?
    var replaceOutput = false
    
    @objc internal func tapNumber(sender: UIButton) {
        guard let titleLabel = sender.titleLabel,
            let text = titleLabel.text,
            let number = Int(text) else {
            debugPrint("Attempting to tap button with no number set on calculator")
            return
        }
        
        lastOperand = nil
        if replaceOutput {
            outputLabel.text = "\(number)"
            replaceOutput = false
        }
        else if outputLabel.text == "" || outputLabel.text == "0" {
            outputLabel.text = text
        }
        else {
            // FIXME: Force unwrapping optional
            outputLabel.text! += "\(number)"
        }
    }

    @objc internal func tapOperator(sender: UIButton) {
        if let buttonTitleLabel = sender.titleLabel {
            
            switch buttonTitleLabel.text {
            case "+":
                handleOperator(currentOperator: .add)
            case "-":
                handleOperator(currentOperator: .subtract)
            case "×":
                handleOperator(currentOperator: .multiply)
            case "÷":
                handleOperator(currentOperator: .divide)
            case "=":
                handleEqualityOperator()
            default:
                debugPrint("\(buttonTitleLabel.text) has not been configured")
            }
        }
    }
    
    internal func handleOperator(currentOperator: Operator) {
        if lastOperator != currentOperator {
            lastOperator = currentOperator
            lastOperand = nil
        }
        
        if let outputText = outputLabel.text,
            let outputNumber = Double(outputText),
            !replaceOutput {
            lastOperator = currentOperator
            
            operands.append(outputNumber)
            replaceOutput = true
            if operands.count > 1 {
                let result = performOperation(currentOperator,
                                              firstOperand: operands[0],
                                              secondOperand: operands[1])
                outputLabel.text = "\(result)"
                lastOperand = operands.popLast()
                operands[0] = result
            }
        }
    }
    
    internal func performOperation(_ currentOperator: Operator,
                                   firstOperand: Double,
                                   secondOperand: Double) -> Double {
        switch currentOperator {
        case .add:
            return firstOperand + secondOperand
        case .subtract:
            return firstOperand - secondOperand
        case .multiply:
            return firstOperand * secondOperand
        case .divide:
            if secondOperand != 0 {
                return firstOperand / secondOperand
            }
            else {
                return firstOperand
            }
        default:
            return 0
        }
    }
    
    internal func handleEqualityOperator() {
        if let outputText = outputLabel.text,
            let outputNumber = Double(outputText),
            let existingLastOperator = lastOperator,
            operands.count == 1 {

            if let existingLastOperand = lastOperand {
                operands[0] = performOperation(existingLastOperator,
                                               firstOperand: operands[0],
                                               secondOperand: existingLastOperand)
            }
            else {
                operands[0] = performOperation(existingLastOperator,
                                               firstOperand: operands[0],
                                               secondOperand: outputNumber)
                lastOperand = outputNumber
            }
            
            outputLabel.text = "\(operands[0])"
            replaceOutput = true
        }
    }
    
    @objc internal func tapSpecial(sender: UIButton) {
        operands = []
        lastOperand = nil
        lastOperator = nil
        replaceOutput = false
        outputLabel.text = "0"
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
            calculatorButtonCell.button.addTarget(self,
                                                  action: #selector(ViewController.tapSpecial(sender:)),
                                                  for: .touchUpInside)
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

