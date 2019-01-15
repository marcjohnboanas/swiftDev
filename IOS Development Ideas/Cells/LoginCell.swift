//
//  LoginCell.swift
//  IOS Development Ideas
//
//  Created by Work on 12/01/2019.
//  Copyright © 2019 Work. All rights reserved.
//

import UIKit

class LoginCell: UICollectionViewCell {
    
    weak var delegate: LoginControllerDelegate?
    
    let emailTextField: LeftPaddedTextField = {
        let tf = LeftPaddedTextField()
        tf.placeholder = "Enter email"
        tf.keyboardType = .emailAddress
        
        //border
        tf.borderStyle = .roundedRect
        tf.layer.borderColor = UIColor.lightGray.cgColor
        tf.layer.borderWidth = 1

        return tf
    }()
    
    let passwordTextField: LeftPaddedTextField = {
        let tf = LeftPaddedTextField()
        tf.placeholder = "Enter password"
        tf.isSecureTextEntry = true
        
        //border
        tf.borderStyle = .roundedRect
        tf.layer.borderColor = UIColor.lightGray.cgColor
        tf.layer.borderWidth = 1

        return tf
    }()
    
    lazy var loginButton: UIButton = {
        let b = UIButton(type: UIButton.ButtonType.roundedRect)
        b.backgroundColor = UIColor.themeColor
        b.setTitleColor(UIColor.white, for: .normal)
        b.setTitle("Login", for: .normal)
        b.addTarget(self, action: #selector(loginUser), for: .touchUpInside)
        return b
    }()
    
    @objc fileprivate func loginUser() {
        delegate?.finishLoggingIn()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .white
        setupLoginForm()
    }
    
    fileprivate func setupLoginForm() {
        addSubview(emailTextField)
        addSubview(passwordTextField)
        addSubview(loginButton)
        emailTextField.anchor(top: nil, leading: leadingAnchor, bottom: nil, trailing: trailingAnchor, padding: UIEdgeInsets(top: 0, left: 32, bottom: 0, right: 32), size: CGSize(width: 0, height: 50))
        emailTextField.centerYAnchor.constraint(equalTo: centerYAnchor, constant: 0).isActive = true
        passwordTextField.anchor(top: emailTextField.bottomAnchor, leading: emailTextField.leadingAnchor, bottom: nil, trailing: emailTextField.trailingAnchor, padding: UIEdgeInsets(top: 16, left: 0, bottom: 0, right: 0), size: CGSize(width: 0, height: 50))
        loginButton.anchor(top: passwordTextField.bottomAnchor, leading: emailTextField.leadingAnchor, bottom: nil, trailing: emailTextField.trailingAnchor, padding: UIEdgeInsets(top: 16, left: 0, bottom: 0, right: 0), size: CGSize(width: 0, height: 50))
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

class LeftPaddedTextField: UITextField {
    override func textRect(forBounds bounds: CGRect) -> CGRect {
        return CGRect(x: bounds.origin.x + 10, y: bounds.origin.y, width: bounds.width + 10, height: bounds.height)
    }
    
    override func editingRect(forBounds bounds: CGRect) -> CGRect {
        return CGRect(x: bounds.origin.x + 10, y: bounds.origin.y, width: bounds.width + 10, height: bounds.height)
    }
}
