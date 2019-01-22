//
//  Bool+Extensions.swift
//  IOS Development Ideas
//
//  Created by Work on 21/01/2019.
//  Copyright © 2019 Work. All rights reserved.
//

import Foundation

extension String {
    func boolValue() -> Bool? {
        switch lowercased() {
        case "true", "yes", "1":
            return true
        case "false", "no", "0":
            return false
        default:
            return nil
        }
    }
}
