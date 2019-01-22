//
//  String+Extensions.swift
//  IOS Development Ideas
//
//  Created by Work on 21/01/2019.
//  Copyright © 2019 Work. All rights reserved.
//

import Foundation

extension String {
    var uppercasedFirstLetter: String {
        guard !self.isEmpty else { return self }
        return prefix(1).uppercased() + dropFirst()
    }
}
