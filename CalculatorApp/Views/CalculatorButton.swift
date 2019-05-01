//
//  CalculatorButton.swift
//  CalculatorApp
//
//  Created by Lukas Carvajal on 02.05.19.
//  Copyright © 2019 AppsByLukas. All rights reserved.
//

import UIKit

class CalculatorButton: UIButton {
    override open var isSelected: Bool {
        didSet {
            backgroundColor = isSelected ? selectedBackgroundColor : deselectedBackgroundColor
        }
    }
    
    internal var deselectedBackgroundColor = UIColor.gray
    internal var selectedBackgroundColor = UIColor.black

    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }
    
    internal func commonInit() {
        clipsToBounds = true
        setTitleColor(.white, for: .normal)
        titleLabel?.font = UIFont.systemFont(ofSize: 40, weight: .regular)
    }
}
