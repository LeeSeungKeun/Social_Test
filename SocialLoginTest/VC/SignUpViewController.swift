//
//  SignUpViewController.swift
//  SocialLoginTest
//
//  Created by 이성근 on 2021/10/25.
//

import UIKit
import FirebaseAuth
import AuthenticationServices

class SignUpViewController: UIViewController {
    @IBOutlet var emailTextField : UITextField!
    @IBOutlet var passwordTextField : UITextField!
    @IBOutlet weak var signUpButton: UIButton!

    override func viewDidLoad() {
        super.viewDidLoad()
        self.hideKeyboard()
        addKeyboardNotification() // 키보드 노티 
    }

    //TODE -- 나중에 Rx로 변경시키자
    @IBAction func signUpAction(_ sender: Any) {
        if emailTextField.text!.isValidPassword() && passwordTextField.text!.isValidPassword() {
            UserService.sheard.requestSignUp(email: emailTextField.text ?? "", password: passwordTextField.text ?? "") { (result)  in
                switch result {
                case .success(_):
                    // create User sucess
                    self.navigationController?.popViewController(animated: true)
                case .failure(let error):
                    // error
                    print("error -> \(error.localizedDescription)")
                }
            }
        }
    }

    private func addKeyboardNotification() {
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(keyboardWillShow),
            name: UIResponder.keyboardWillShowNotification,
            object: nil
        )

        NotificationCenter.default.addObserver(
            self,
            selector: #selector(keyboardWillHide),
            name: UIResponder.keyboardWillHideNotification,
            object: nil
        )
    }

    @objc private func keyboardWillShow(_ notification: Notification) {
        if let keyboardFrame: NSValue = notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue {
            let keybaordRectangle = keyboardFrame.cgRectValue
            let keyboardHeight = keybaordRectangle.height
            signUpButton.frame.origin.y -= keyboardHeight
        }
    }

    @objc private func keyboardWillHide(_ notification: Notification) {
        if let keyboardFrame: NSValue = notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue {
            let keybaordRectangle = keyboardFrame.cgRectValue
            let keyboardHeight = keybaordRectangle.height
            signUpButton.frame.origin.y += keyboardHeight
        }
    }
}

extension SignUpViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField == emailTextField { //
            passwordTextField.becomeFirstResponder()
        } else {
            passwordTextField.resignFirstResponder()
        }
        return true
    }
}
