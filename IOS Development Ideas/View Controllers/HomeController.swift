//
//  HomeController.swift
//  IOS Development Ideas
//
//  Created by Work on 15/01/2019.
//  Copyright © 2019 Work. All rights reserved.
//

import UIKit

class HomeController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavBar()
    }
    
    fileprivate func setupNavBar() {
        navigationItem.title = "Logged In!"
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Sign Out", style: .plain, target: self, action: #selector(logoutUser))
    }
    
    @objc fileprivate func logoutUser() {
        UserDefaults.standard.setIsLoggedIn(value: false)
        let loginController = LoginController()
        present(loginController, animated: true) {}
    }
}
