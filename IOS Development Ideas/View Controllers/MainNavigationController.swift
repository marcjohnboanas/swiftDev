//
//  MainNavigationController.swift
//  IOS Development Ideas
//
//  Created by Work on 14/01/2019.
//  Copyright © 2019 Work. All rights reserved.
//

import UIKit

class MainNavigationController: UINavigationController {
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        if UserDefaults.standard.isLoggedIn() {
            let homeController = HomeController()
            viewControllers = [homeController]
        } else {
            perform(#selector(showLoginController), with: nil, afterDelay: 0.01)
        }
    }
    
    @objc fileprivate func showLoginController() {
        let loginController = LoginController()
        present(loginController, animated: true) {
            //something??
        }
    }
}
