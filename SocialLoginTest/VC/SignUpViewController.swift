//
//  SignUpViewController.swift
//  SocialLoginTest
//
//  Created by 이성근 on 2021/10/25.
//

import UIKit

class SignUpViewController: UIViewController {
    @IBOutlet var emailTextField : UITextField!
    @IBOutlet var passwordTextField : UITextField!

    override func viewDidLoad() {
        super.viewDidLoad()
        self.hideKeyboard()

    }    
}
