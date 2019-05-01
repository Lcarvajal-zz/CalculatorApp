//
//  WideCalculatorButtonCollectionViewCell.swift
//  CalculatorApp
//
//  Created by Lukas Carvajal on 01.05.19.
//  Copyright © 2019 AppsByLukas. All rights reserved.
//

import UIKit

class WideCalculatorButtonCollectionViewCell: CalculatorButtonCollectionViewCell {
    override func commonInit() {
        super.commonInit()
        
        button.titleEdgeInsets.left = 5
        button.titleEdgeInsets.right = frame.width / 2
    }
}
