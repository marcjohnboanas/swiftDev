//
//  UIView+Extensions.swift
//  IOS Development Ideas
//
//  Created by Work on 21/01/2019.
//  Copyright © 2019 Work. All rights reserved.
//

import Foundation
import UIKit

extension UIView {
    
    func createImage() -> UIImage? {
        
        UIGraphicsBeginImageContextWithOptions(frame.size, false, 0)
        drawHierarchy(in: frame, afterScreenUpdates: true)
        
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        return image
    }
}
