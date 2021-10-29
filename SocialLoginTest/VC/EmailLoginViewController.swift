//
//  LoginViewController.swift
//  SocialLoginTest
//
//  Created by 이성근 on 2021/10/18.
//

import UIKit

class EmailLoginViewController: UIViewController {

    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
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

    @IBAction func loginActoin(_ : UIButton) {
        let email = emailTextField.text ?? ""
        let pwd = passwordTextField.text ?? ""

        // email Login Actoin
        LoginService.sheard.requestFirebaseLogin(email: email, password: pwd) { result in
            switch result {
            case .success(let uid):
                print("uid login scueess")
                let storyboard = UIStoryboard(name: "Main", bundle: nil)
                let vc = storyboard.instantiateViewController(identifier: "MyViewController")
                self.navigationController?.pushViewController(vc, animated: true)
                
            case .failure(let error):
                print("error : " , error.localizedDescription)
            }
        }
    }
    

}
