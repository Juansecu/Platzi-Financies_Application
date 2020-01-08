//
//  Numeric.swift
//  Financies
//
//  Created by Juan on 1/8/20.
//  Copyright © 2020 Juan. All rights reserved.
//

import Foundation

extension Numeric {
    func currency() -> String {
        let formatter = NumberFormatter()
        formatter.locale = Locale.current
        formatter.numberStyle = .currency
        guard let formatted = formatter.string(from: self as! NSNumber) else {
            return "\(self)"
        }
        
        return formatted
    }
}
