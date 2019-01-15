//
//  UserDefaults.swift
//  IOS Development Ideas
//
//  Created by Work on 15/01/2019.
//  Copyright © 2019 Work. All rights reserved.
//

import Foundation

extension UserDefaults {
    
    enum UserDefaultKeys: String {
        case isLoggedIn
    }
    
    func setIsLoggedIn(value: Bool) {
        set(value, forKey: UserDefaultKeys.isLoggedIn.rawValue)
        synchronize()
    }
    
    func isLoggedIn() -> (Bool) {
        return bool(forKey: UserDefaultKeys.isLoggedIn.rawValue)
    }
}
