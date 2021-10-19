//
//  LoginService.swift
//  SocialLoginTest
//
//  Created by 이성근 on 2021/10/19.
//

import Foundation


protocol LoginServiceProtocl {
    func requestFirebaseLogin(email : String , password : String , compleation : @escaping (Result<String, Error>) ->() )

    func requestGoogleLogin(email : String , password : String , compleation : @escaping (Result<String, Error>) ->() )

    func requestAppleLogin(email : String , password : String , compleation : @escaping (Result<String, Error>) ->() )

    func requestKaKaoLogin(email : String , password : String , compleation : @escaping (Result<String, Error>) ->() )
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

    }
    func requestGoogleLogin(email : String , password : String , compleation : @escaping (Result<String, Error>) ->() ) {

    }

    func requestAppleLogin(email : String , password : String , compleation : @escaping (Result<String, Error>) ->() ) {

    }

    func requestKaKaoLogin(email : String , password : String , compleation : @escaping (Result<String, Error>) ->() ) {

    }
}
