//
//  UIImage+Extensions.swift
//  IOS Development Ideas
//
//  Created by Work on 21/01/2019.
//  Copyright © 2019 Work. All rights reserved.
//

import Foundation
import UIKit

extension UIImage {
    func imageWith(newSize: CGSize) -> UIImage {
        let renderer = UIGraphicsImageRenderer(size:newSize)
        let image = renderer.image {_ in
            draw(in: CGRect.init(origin: CGPoint.zero, size: newSize))
        }
        
        return image
    }
}
