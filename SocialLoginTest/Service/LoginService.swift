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

    func requestAppleLogin(email : String , password : String , compleation : @escaping (Result<String, Error>) ->() )

    func requestKaKaoLogin(compleation : @escaping (Result<OAuthToken, Error>) ->() )
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

    func requestAppleLogin(email : String , password : String , compleation : @escaping (Result<String, Error>) ->() ) {
        
    }

    func requestKaKaoLogin(compleation : @escaping (Result<OAuthToken, Error>) ->() ) {
        // kakoTalk 로그인!
        if (UserApi.isKakaoTalkLoginAvailable()) { // 카카오톡 다운로드 여부
            UserApi.shared.loginWithKakaoTalk {(oauthToken, error) in
                if let error = error {
                    print(error)
                }
                else {
                    print("loginWithKakaoTalk success.")
                    guard let token = oauthToken else {return}
                    compleation(.success(token))
                }
            }
        }else {
            // 아래는 시뮬레이터용 
            UserApi.shared.loginWithKakaoAccount {(oauthToken, error) in
                if let error = error {
                    print(error)
                }
                else {
                    print("loginWithKakaoAccount() success.")

                    //do something
                    let _ = oauthToken
                }
            }
        }
    }
}
