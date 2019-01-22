//
//  UIWindow+Extensions.swift
//  IOS Development Ideas
//
//  Created by Work on 21/01/2019.
//  Copyright © 2019 Work. All rights reserved.
//

import Foundation
import UIKit

extension UIWindow {
    
    class var key: UIWindow {
        guard let keyWindow = UIApplication.shared.keyWindow else { fatalError("Fatal Error: now window is set to keyWindow") }
        return keyWindow
    }
    
    class var keySafeAreaInsets: UIEdgeInsets {
        guard #available(iOS 11.0, *) else { return .zero }
        return UIWindow.key.safeAreaInsets
    }
}
