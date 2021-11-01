//
//  LoginSelectViewController.swift
//  SocialLoginTest
//
//  Created by 이성근 on 2021/10/18.
//

import UIKit
import GoogleSignIn
import FirebaseAuth
import AuthenticationServices

class LoginSelectViewController: UIViewController {

    @IBOutlet var loginButtons: [UIButton]!

    @IBOutlet weak var appleLoginButton: ASAuthorizationAppleIDButton!
    @IBOutlet weak var googleLoginButton: GIDSignInButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.navigationBar.isHidden = true
        self.loginButtons.forEach {
            $0.layer.cornerRadius = 25
            $0.layer.borderColor = UIColor.white.cgColor
            $0.layer.borderWidth = 1
        }

        appleLoginButton.addTarget(self, action: #selector(didTapAppleLoginButton), for: .touchUpInside)
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        GIDSignIn.sharedInstance()?.presentingViewController = self // 프레젠팅뷰 설정
    }

    @objc func didTapAppleLoginButton(){
        let request = ASAuthorizationAppleIDProvider().createRequest() // 요청
        request.requestedScopes = [.email,.fullName]

        let authorzationController = ASAuthorizationController(authorizationRequests: [request])
        authorzationController.delegate = self
        authorzationController.presentationContextProvider = self
        authorzationController.performRequests()
    }

    private func pushMainView(identifier : String){
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyboard.instantiateViewController(identifier: identifier)
        self.navigationController?.pushViewController(vc, animated: true)
    }

    @IBAction func emailLoginAction(_ sender: UIButton) {
        pushMainView(identifier: "EmailLoginViewController")
    }


    @IBAction func kakaoLoginAction(_ sender: UIButton) {
        LoginService.sheard.requestKaKaoLogin { (result) in
            switch result {
            case .success(let token):
                print("SUCESS")
                self.pushMainView(identifier : "MyViewController")
            case .failure(let error):
                print("ERROR" , error.localizedDescription)
                // error
            }
        }
    }

    @IBAction func appleLoginAction(_ sender: UIButton) {

    }

    @IBAction func googleLoginAction(_ sender: UIButton) {
        GIDSignIn.sharedInstance()?.signIn()
    }
}


extension LoginSelectViewController : ASAuthorizationControllerDelegate {
    func authorizationController(controller: ASAuthorizationController, didCompleteWithAuthorization authorization: ASAuthorization) {
        guard let credential = authorization.credential as? ASAuthorizationAppleIDCredential else {return}

//        guard let token = credential.identityToken else {return}
//        guard let code = credential.authorizationCode else { return }
//        guard let name = credential.fullName else {return}
//        let user = credential.user
//        let email = credential.email

    }

    func authorizationController(controller: ASAuthorizationController, didCompleteWithError error: Error) {
        print("error -> \(error.localizedDescription)")
    }
}

extension LoginSelectViewController : ASAuthorizationControllerPresentationContextProviding {
    func presentationAnchor(for controller: ASAuthorizationController) -> ASPresentationAnchor {
        return self.view.window!
    }


}
