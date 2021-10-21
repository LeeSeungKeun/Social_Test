
//  FirebaseManager.swift
//  SocialLoginTest
//
//  Created by 이성근 on 2021/10/21.
//

import Foundation
import FirebaseAuth


protocol UserServiceProtocl {
    func requestSignUp(email : String , password : String , compleation : @escaping (Result<String,Error>)->())
}

class UserService : UserServiceProtocl {
    func requestSignUp(email: String, password: String, compleation: @escaping (Result<String, Error>) -> ()) {
        Auth.auth().createUser(withEmail: email, password: password) { (auth, error) in
            if let err = error {
                compleation(.failure(err))
            }
            if let user = auth {
                compleation(.success(user.user.uid))
            }
        }
    }
}
