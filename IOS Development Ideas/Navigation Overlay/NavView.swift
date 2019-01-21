//
//  NavView.swift
//  IOS Development Ideas
//
//  Created by Work on 19/01/2019.
//  Copyright © 2019 Work. All rights reserved.
//

import UIKit

class NavView: UIView {
    
    // MARK: - Properties
    lazy var buttonTwoWidthConstraintConstant: CGFloat = {
        return self.buttonTwoWidthConstraint.constant
    }()
    lazy var buttonTwoBottomConstraintConstant: CGFloat = {
        return self.buttonTwoBottomConstraint.constant
    }()
    lazy var buttonOneWidthConstraintConstant: CGFloat = {
        return self.buttonOneWidthConstraint.constant
    }()
    lazy var buttonOneBottomConstraintConstant: CGFloat = {
        return self.buttonOneBottomConstraint.constant
    }()
    lazy var buttonOneHorizontalConstraintConstant: CGFloat = {
        return self.buttonOneHorizontalConstraint.constant
    }()
    lazy var buttonThreeHorizontalConstraintConstant: CGFloat = {
        return self.buttonThreeHorizontalConstraint.constant
    }()
    lazy var indicatorTransform: CGAffineTransform = {
        return self.buttonTwoView.transform
    }()
    
    @IBOutlet weak var buttonOneView: UIView!
    @IBOutlet weak var buttonOneWidthConstraint: NSLayoutConstraint!
    @IBOutlet weak var buttonOneBottomConstraint: NSLayoutConstraint!
    @IBOutlet weak var buttonOneHorizontalConstraint: NSLayoutConstraint!
    
    @IBOutlet weak var buttonTwoView: UIView!
    @IBOutlet weak var buttonTwoWidthConstraint: NSLayoutConstraint!
    @IBOutlet weak var buttonTwoBottomConstraint: NSLayoutConstraint!
    
    @IBOutlet weak var buttonThreeView: UIView!
    @IBOutlet weak var buttonThreeHorizontalConstraint: NSLayoutConstraint!
    
    @IBOutlet weak var indicatorView: UIView!
    
    @IBOutlet weak var colorView: UIView!
    
    override func awakeFromNib() {
        setupViews()
    }
    
    override func prepareForInterfaceBuilder() {
        setupViews()
    }
    
    fileprivate func setupViews() {
        [buttonOneView, buttonTwoView, buttonThreeView, indicatorView].forEach({
            $0?.backgroundColor = UIColor.white
            $0?.isUserInteractionEnabled = true
        })
    }
    
    override func hitTest(_ point: CGPoint, with event: UIEvent?) -> UIView? {
        let view = super.hitTest(point, with: event)
        return view == self ? nil : view
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        indicatorView.layer.cornerRadius = indicatorView.bounds.height / 2
    }
    
    func animate(to controller: UIViewController?, percent: CGFloat) {
        let offset = abs(percent)
        
        animateButtonPosition(offset: offset)
        animateButtonScale(offset: offset)
        animateButtonCenter(offset: offset)
        
        animateBottomBar(percent: percent)
        
        // Background color view
        if let controller = controller as? ColoredView {
            colorView.backgroundColor = controller.controllerColor
        }
        
        var colorOffset = (offset - 0.2) / (0.8 - 0.2)
        colorOffset = min(max(colorOffset, 0), 1)
        colorView.alpha = colorOffset
        
        layoutIfNeeded()
    }
}
