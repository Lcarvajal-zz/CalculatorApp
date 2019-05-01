//
//  ViewController.swift
//  CalculatorApp
//
//  Created by Lukas Carvajal on 25.04.19.
//  Copyright © 2019 AppsByLukas. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    fileprivate let buttonTexts = Constant.calculatorButtons
    
    fileprivate var replaceOutput = false
    
    fileprivate let outputLabel =  NumberOutputLabel()
    fileprivate var buttonsCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.minimumInteritemSpacing = 0
        layout.minimumLineSpacing = 0

        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.backgroundColor = .black
        collectionView.register(CalculatorButtonCollectionViewCell.self,
                                forCellWithReuseIdentifier: "Cell")
        collectionView.register(WideCalculatorButtonCollectionViewCell.self,
                                forCellWithReuseIdentifier: "WideCell")
        return collectionView
    }()
    
    fileprivate var calculator = Calculator()
    
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
        
        if replaceOutput
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
            let currentOperator = Operator(rawValue: buttonTitleLabelText),
            let outputLabelText = outputLabel.text,
            let outputNumber = Double(outputLabelText) else {
                return
        }
        
        deselectOperatorButtons()
        sender.isSelected = true
        
        replaceOutput = true
        calculator.gather(number: outputNumber, operatorInput: currentOperator)
        outputLabel.text = calculator.getFirstFormattedOperand()
    }
    
    @objc internal func tapEqualSign(sender: UIButton) {
        guard let buttonTitleLabel = sender.titleLabel,
            let buttonTitleLabelText = buttonTitleLabel.text,
            let currentOperator = Operator(rawValue: buttonTitleLabelText),
            let outputLabelText = outputLabel.text,
            let outputNumber = Double(outputLabelText) else {
                return
        }
        
        deselectOperatorButtons()
        replaceOutput = true
        calculator.gather(number: outputNumber, operatorInput: currentOperator)
        outputLabel.text = calculator.getFirstFormattedOperand()
    }
    
    @objc internal func tapSpecial(sender: UIButton) {
        guard let buttonTitleLabel = sender.titleLabel,
            let buttonTitleLabelText = buttonTitleLabel.text else {
                return
        }
        deselectOperatorButtons()
        
        switch buttonTitleLabelText {
        case Constant.Sign.clear:
            calculator.reset()
            replaceOutput = false
            outputLabel.text = "0"
        case Constant.Sign.plusMinus:
            guard let outputLabelText = outputLabel.text,
                outputLabelText != "0"
                else { return }
            
            if outputLabelText.contains("-") {
                outputLabel.text?.removeFirst()
            }
            else {
                outputLabel.text?.insert("-", at: outputLabelText.startIndex)
            }
            
            if calculator.repeatPreviousCalculation,
                let outputNumber = Double(outputLabel.text!) {
                calculator.operands[0] = outputNumber
            }
        default:
            debugPrint("Attempting to permform \(buttonTitleLabelText), which hasn't been configured")
        }
    }
    
    // MARK: - Output label
    
    fileprivate func replaceOutputLabelText(with text: String) {
        if text != "." {
            outputLabel.text = text
        }
        else if !outputLabel.text!.contains(".") {
            outputLabel.text = "0."
        }
        replaceOutput = false
    }
    
    // MARK: - Calculator buttons
    
    fileprivate func getSelectedOperatorButton() -> UIButton? {
        let operators = [Constant.Sign.addition,
                         Constant.Sign.subtraction,
                         Constant.Sign.multiplication,
                         Constant.Sign.division]
       
        for operatorSign in operators {
            if let operatorIndex = buttonTexts.firstIndex(of: operatorSign) {
                let indexPath = IndexPath(row: operatorIndex, section: 0)
                if let cell = buttonsCollectionView.cellForItem(at: indexPath) as? CalculatorButtonCollectionViewCell,
                    cell.button.isSelected {
                    return cell.button
                }
                
            }
        }
        
        return nil
    }
    
    fileprivate func deselectOperatorButtons() {
        let operators = [Constant.Sign.addition,
                         Constant.Sign.subtraction,
                         Constant.Sign.multiplication,
                         Constant.Sign.division]
        
        for operatorSign in operators {
            if let operatorIndex = buttonTexts.firstIndex(of: operatorSign) {
                let indexPath = IndexPath(row: operatorIndex, section: 0)
                
                if let cell = buttonsCollectionView.cellForItem(at: indexPath) as? CalculatorButtonCollectionViewCell {
                    cell.button.isSelected = false
                }
            }
        }
    }
    
    // MARK: - Constraints
    
    fileprivate func configureConstraints() {
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
        return buttonTexts.count
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let buttonText = buttonTexts[indexPath.row]
        var calculatorButtonCell = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell",
                                                                                          for: indexPath) as! CalculatorButtonCollectionViewCell
        
        switch buttonText {
        case Constant.Sign.clear,
             Constant.Sign.plusMinus,
             Constant.Sign.percentage:
            calculatorButtonCell.styleDark(buttonText)
            calculatorButtonCell.button.addTarget(self,
                                                  action: #selector(ViewController.tapSpecial(sender:)),
                                                  for: .touchUpInside)
        case Constant.Sign.division,
             Constant.Sign.multiplication,
             Constant.Sign.subtraction,
             Constant.Sign.addition:
            calculatorButtonCell.styleBright(buttonText)
            calculatorButtonCell.button.addTarget(self,
                                                  action: #selector(ViewController.tapOperator(sender:)),
                                                  for: .touchUpInside)
        case Constant.Sign.equal:
            calculatorButtonCell.styleBright(buttonText)
            calculatorButtonCell.button.addTarget(self,
                                                  action: #selector(ViewController.tapEqualSign(sender:)),
                                                  for: .touchUpInside)
        case "0":
            calculatorButtonCell = collectionView.dequeueReusableCell(withReuseIdentifier: "WideCell",
                                                                      for: indexPath) as! WideCalculatorButtonCollectionViewCell
            calculatorButtonCell.styleLight(buttonText)
            calculatorButtonCell.button.addTarget(self,
                                                  action: #selector(ViewController.tapNumber(sender:)),
                                                  for: .touchUpInside)
        default:
            calculatorButtonCell.styleLight(buttonText)
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
        
        let size: CGSize
        
        if buttonTexts[indexPath.row] == "0" {
            let oneHalfOfScreenWidth = oneFourthOfScreenWidth * 2
            size = CGSize(width: oneHalfOfScreenWidth,
                          height: oneFourthOfScreenWidth)
        }
        else {
            size = CGSize(width: oneFourthOfScreenWidth,
                          height: oneFourthOfScreenWidth)
        }
        
        return size
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
}

