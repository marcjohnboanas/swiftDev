//
//  NavViewAnimation.swift
//  IOS Development Ideas
//
//  Created by Work on 19/01/2019.
//  Copyright © 2019 Work. All rights reserved.
//

import UIKit

extension NavView {
    
    func animateButtonPosition(offset: CGFloat) {
        // Line the controls up along the bottom
        let finalDistanceFromBottom: CGFloat = 25.0
        var distance = buttonTwoBottomConstraintConstant - finalDistanceFromBottom
        buttonTwoBottomConstraint.constant = buttonTwoBottomConstraintConstant - (distance * offset)
        distance = buttonOneBottomConstraintConstant - finalDistanceFromBottom
        buttonOneBottomConstraint.constant = buttonOneBottomConstraintConstant - (distance * offset)
    }
    
    func animateButtonScale(offset: CGFloat) {
        // Scale the controls using width constraints
        let finalWidthScale: CGFloat = buttonTwoWidthConstraintConstant * 0.2
        buttonTwoWidthConstraint.constant = buttonTwoWidthConstraintConstant - (finalWidthScale * offset)
        let scale = buttonOneWidthConstraintConstant * 0.2
        buttonOneWidthConstraint.constant = buttonOneWidthConstraintConstant - (scale * offset)
    }
    
    func animateButtonCenter(offset: CGFloat) {
        let originalMultiplier = buttonOneHorizontalConstraint.multiplier * bounds.width * 0.5
        let newMultiplier = (bounds.width * 0.54 * 0.5) - originalMultiplier
        buttonOneHorizontalConstraint.constant = newMultiplier * offset
        buttonThreeHorizontalConstraint.constant = -newMultiplier * offset
    }
    
    func animateBottomBar(percent: CGFloat) {
        // Controller Indicator Line
        let offset = abs(percent)
        let scaleTransform = CGAffineTransform(scaleX: offset, y: 1)
        let distance = 0.23 * bounds.width
        
        // use percent as it has the correct sign
        let transform = indicatorTransform.translatedBy(x: distance * percent, y: 0)
        indicatorView.transform = transform.concatenating(scaleTransform)
        indicatorView.alpha = offset
    }
}
