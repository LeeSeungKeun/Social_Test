//
//  LoginService.swift
//  SocialLoginTest
//
//  Created by 이성근 on 2021/10/19.
//

import Foundation
import KakaoSDKUser
import KakaoSDKCommon
import KakaoSDKAuth
import FirebaseAuth

protocol LoginServiceProtocl {
    func requestFirebaseLogin(email : String , password : String , compleation : @escaping (Result<String, Error>) ->() )

    func requestGoogleLogin(email : String , password : String , compleation : @escaping (Result<String, Error>) ->() )

    func requestAppleLogin(email : String , password : String , compleation : @escaping (Result<String, Error>) ->() )

    func requestKaKaoLogin(email : String , password : String , compleation : @escaping (Result<OAuthToken, Error>) ->() )
}

enum MyError : Error {
    case invalidEmail
    case invalidPassword
    case jsonEncodeErro
}

class LoginService : LoginServiceProtocl{
    static let sheard = LoginService()
    private init(){}

    func requestFirebaseLogin(email : String , password : String , compleation : @escaping (Result<String, Error>) ->() ) {
        Auth.auth().signIn(withEmail: email, password: password) { (result, error) in
            if let error = error {
                compleation(.failure(error))
            }
            if let user = result {
                compleation(.success(user.user.uid))
            }
        }
    }
    func requestGoogleLogin(email : String , password : String , compleation : @escaping (Result<String, Error>) ->() ) {

    }

    func requestAppleLogin(email : String , password : String , compleation : @escaping (Result<String, Error>) ->() ) {

    }

    func requestKaKaoLogin(email : String , password : String , compleation : @escaping (Result<OAuthToken, Error>) ->() ) {
        // kakoTalk 로그인!
        if (UserApi.isKakaoTalkLoginAvailable()) {
            UserApi.shared.loginWithKakaoTalk {(oauthToken, error) in
                if let error = error {
                    print(error)
                }
                else {
                    print("loginWithKakaoTalk() success.")
                    guard let token = oauthToken else {return}

                }
            }
        }
    }
}
