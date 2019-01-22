//
//  ViewController.swift
//  IOS Development Ideas
//
//  Created by Work on 10/01/2019.
//  Copyright © 2019 Work. All rights reserved.
//

import UIKit

extension UIColor {
    static let backgroundColor = UIColor(red: 219/255, green: 103/255, blue: 116/255, alpha: 0.0)
    static let topColor = UIColor(red: 154/255, green: 74/255, blue: 50/255, alpha: 1.0)
    static let bottomColor = UIColor(red: 171/255, green: 94/255, blue: 91/255, alpha: 0.1)
}

class ViewController: UIViewController {
    
    override var prefersStatusBarHidden: Bool {
        return true
    }
    
    let backgroundGradientLayer = CAGradientLayer()
    let targetView = UIView()
    
    private struct Colors {
        static let pink = #colorLiteral(red: 0.9294117647, green: 0.5215686275, blue: 0.568627451, alpha: 1)
        static let beige = #colorLiteral(red: 0.968627451, green: 0.8274509804, blue: 0.6666666667, alpha: 1)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupGradientView()
    }
    
    fileprivate func setupGradientView() {
        targetView.translatesAutoresizingMaskIntoConstraints = false
        targetView.clipsToBounds = true
        //targetView.backgroundColor = UIColor.backgroundColor
        targetView.layer.cornerRadius = 0
        
        view.addSubview(targetView)
        targetView.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 0).isActive = true
        targetView.rightAnchor.constraint(equalTo: view.rightAnchor, constant: 0).isActive = true
        targetView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        targetView.heightAnchor.constraint(equalToConstant: 10).isActive = true
        
        backgroundGradientLayer.colors = [Colors.pink.cgColor, Colors.beige.cgColor, Colors.pink.cgColor]
        backgroundGradientLayer.locations = [0.0, 0.0, 0.4]
        backgroundGradientLayer.startPoint = CGPoint(x: 0.0, y: 0.5)
        backgroundGradientLayer.endPoint = CGPoint(x: 1.0, y: 0.5)
        targetView.layer.addSublayer(backgroundGradientLayer)
        
        let gradientAnimation = CABasicAnimation(keyPath: "locations")
        gradientAnimation.duration = 1.5
        gradientAnimation.fromValue = [0.0, 0.0, 0.4]
        gradientAnimation.toValue = [0.4, 0.9, 1.0]
        //gradientAnimation.fillMode = .forwards
        gradientAnimation.repeatCount = .infinity
        self.backgroundGradientLayer.add(gradientAnimation, forKey: "locationsChange")
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        backgroundGradientLayer.frame = targetView.bounds
        print(targetView.bounds)
    }
}
