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
        "0", "0", ".", "="
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
        guard let numberButtonTitleLabel = sender.titleLabel,
            let numberButtonText = numberButtonTitleLabel.text else {
            debugPrint("Attempting to tap button with no number set on calculator")
            return
        }
        
        calculator.lastOperand = nil
        
        if calculator.replaceOutput
            || outputLabel.text == "" || outputLabel.text == "0" {
            replaceOutputLabelText(with: numberButtonText)
        }
        else if numberButtonText != "."
            || !outputLabel.text!.contains(".")  {
            outputLabel.text! += numberButtonText
        }
    }

    @objc internal func tapOperator(sender: UIButton) {
        guard let buttonTitleLabel = sender.titleLabel,
            let buttonTitleLabelText = buttonTitleLabel.text,
            let currentOperator = Operator(rawValue: buttonTitleLabelText) else {
                return
        }
        
        if currentOperator == .equals {
            handleEqualityOperator()
        }
        else {
            handleNonEqualityOperator(currentOperator)
        }
    }
    
    @objc internal func tapSpecial(sender: UIButton) {
        calculator.reset()
        outputLabel.text = "0"
    }
    
    // MARK: - Output label and calculations
    
    fileprivate func replaceOutputLabelText(with text: String) {
        if text != "." {
            outputLabel.text = text
        }
        else if !outputLabel.text!.contains(".") {
            outputLabel.text = "0."
        }
        calculator.replaceOutput = false
    }
    
    fileprivate func handleEqualityOperator() {
        // FIXME: This code handles the cases where a user wants to tap the equality operator multiple times to continue performing the last performed operation. It should get refactored.
        
        guard let outputText = outputLabel.text,
            let outputNumber = Double(outputText),
            let existingLastOperator = calculator.lastOperator,
            calculator.operands.count == 1 else {
                return
        }

        if let existingLastOperand = calculator.lastOperand {
            calculator.operands[0] = calculator.performOperation(existingLastOperator,
                                                                 firstOperand: calculator.operands[0],
                                                                 secondOperand: existingLastOperand)
        }
        else {
            calculator.operands[0] = calculator.performOperation(existingLastOperator,
                                                                 firstOperand: calculator.operands[0],
                                                                 secondOperand: outputNumber)
            calculator.lastOperand = outputNumber
        }
        
        outputLabel.text = "\(calculator.operands[0])"
        calculator.replaceOutput = true
    }
    
    fileprivate func handleNonEqualityOperator(_ currentOperator: Operator) {
        // FIXME: This code handles the cases where a user wants to tap the equality operator multiple times to continue performing the last performed operation. It should get refactored.
        
        if calculator.lastOperator != currentOperator {
            calculator.lastOperator = currentOperator
            calculator.lastOperand = nil
        }
        
        guard let outputText = outputLabel.text,
            let outputNumber = Double(outputText) else {
                return
        }
        
        if !calculator.replaceOutput {
            calculator.lastOperator = currentOperator
            calculator.operands.append(outputNumber)
            calculator.replaceOutput = true
            
            if calculator.operands.count > 1 {
                let result = calculator.performOperation(currentOperator,
                                                         firstOperand: calculator.operands[0],
                                                         secondOperand: calculator.operands[1])
                outputLabel.text = "\(result)"
                calculator.lastOperand = calculator.operands.popLast()
                calculator.operands[0] = result
            }
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

