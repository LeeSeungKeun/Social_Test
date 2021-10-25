//
//  VC+Keyboard.swift
//  SocialLoginTest
//
//  Created by 이성근 on 2021/10/25.
//

import Foundation
import UIKit

extension UIViewController
{
    // keyboard 하이드 추가
    func hideKeyboard()
    {
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(UIViewController.dismissKeyboard))
        view.addGestureRecognizer(tap) // 제스처 추가
    }

    @objc func dismissKeyboard()
    {
        view.endEditing(true)
    }
}
