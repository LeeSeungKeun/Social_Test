//
//  UIColor.swift
//  SocialLoginTest
//
//  Created by 이성근 on 2021/10/18.
//

import UIKit

enum CustomColor {
    case buttonColor
}


extension UIColor {
    static func appColor(_ name : CustomColor) -> UIColor {
        switch name {
        case .buttonColor:
            return #colorLiteral(red: 0.9098039269, green: 0.4784313738, blue: 0.6431372762, alpha: 1)
        }

    }
}
