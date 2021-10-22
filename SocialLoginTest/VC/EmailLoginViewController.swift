//
//  LoginViewController.swift
//  SocialLoginTest
//
//  Created by 이성근 on 2021/10/18.
//

import UIKit

class EmailLoginViewController: UIViewController {

    @IBOutlet weak var signUpButton: UIButton!
    @IBOutlet weak var loginButton: UIButton!

    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "이메일 로그인!!!!"
        self.navigationController?.isNavigationBarHidden = false
        [signUpButton , loginButton].forEach {
            $0?.backgroundColor = UIColor.appColor(.buttonColor)
            $0?.layer.cornerRadius = 8
            $0?.setTitleColor(.white, for: .normal)
        }
    }

    

}
