//
//  LoginSelectViewController.swift
//  SocialLoginTest
//
//  Created by 이성근 on 2021/10/18.
//

import UIKit
import GoogleSignIn

class LoginSelectViewController: UIViewController {

    @IBOutlet var loginButtons: [UIButton]!

    @IBOutlet weak var googleLoginButton: GIDSignInButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.navigationBar.isHidden = true
        self.loginButtons.forEach {
            $0.layer.cornerRadius = 25
            $0.layer.borderColor = UIColor.white.cgColor
            $0.layer.borderWidth = 1
        }
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        GIDSignIn.sharedInstance()?.presentingViewController = self // 프레젠팅뷰 설정
    }

    @IBAction func emailLoginAction(_ sender: UIButton) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyboard.instantiateViewController(identifier: "EmailLoginViewController")
        self.navigationController?.pushViewController(vc, animated: true)
    }


    @IBAction func kakaoLoginAction(_ sender: UIButton) {
        LoginService.sheard.requestKaKaoLogin { (result) in
            switch result {
            case .success(let token):
                print("SUCESS")
                // 성공여부
            case .failure(let error):
                print("ERROR" , error.localizedDescription)
                // error
            }
        }
    }

    @IBAction func appleLoginAction(_ sender: UIButton) {

    }

    @IBAction func googleLoginAction(_ sender: UIButton) {
    }
}
