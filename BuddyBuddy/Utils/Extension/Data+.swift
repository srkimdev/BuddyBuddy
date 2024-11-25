//
//  Data+.swift
//  BuddyBuddy
//
//  Created by Jisoo Ham on 11/22/24.
//

import UIKit

extension Data {
    func toUIImage() -> UIImage? {
        return UIImage(data: self)
    }
}
