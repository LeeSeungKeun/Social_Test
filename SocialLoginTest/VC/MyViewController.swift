//
//  MyViewController.swift
//  SocialLoginTest
//
//  Created by 이성근 on 2021/10/17.
//

import UIKit
import FirebaseAuth
import KakaoSDKUser

enum LoginCase {
    case KaKao
    case Firebase
}

class MyViewController: UIViewController {

    @IBOutlet weak var userImageView: UIButton!
    @IBOutlet weak var emailLabel: UILabel!

    var loginCase : LoginCase = .Firebase

    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.interactivePopGestureRecognizer?.isEnabled = false
        navigationController?.navigationBar.isHidden = true

    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setFirebaseUserInfo()
        setKaKaoUserInfo()
    }

    func setKaKaoUserInfo(){
        UserApi.shared.me { (user, error) in
            if let error = error {
                print("kakao Login Error -> \(error.localizedDescription)")
            }else {
                print("LoginSucess")
                self.emailLabel.text = "카카오 로그인 완료!!"
                self.loginCase = .KaKao
            }
        }
    }


    func setFirebaseUserInfo() {
        if let user = Auth.auth().currentUser {
            guard let email = user.email else {return}
            emailLabel.text = "\(email)님 게임 참여를 축하합니다!!"
        }
    }

    @IBAction func logOutAction(_ sender: Any) {

        switch loginCase {
        case .Firebase:
            let firebaseAuth = Auth.auth()
            do {
                try firebaseAuth.signOut()
                self.navigationController?.popViewController(animated: true)
            } catch let signOutError as NSError {
                print("Error signing out: %@", signOutError)
            }
        case .KaKao:
            UserApi.shared.logout { (error) in
                if let error = error {
                    print(error.localizedDescription)
                }else {
                    self.navigationController?.popViewController(animated: true)
                }
            }
        }
    }

    @IBAction func openCameraAction(_ sender: Any) {
    }
}
