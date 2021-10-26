//
//  String+Validation.swift
//  SocialLoginTest
//
//  Created by 이성근 on 2021/10/26.
//

import Foundation


extension String {
    func isValidateEmail() -> Bool {
        let emailReg = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        let emailRegTest = NSPredicate(format:"SELF MATCHES %@", emailReg)
        return emailRegTest.evaluate(with: self)
    }

    func isValidPassword() -> Bool {
        //숫자+문자 포함해서 8~20글자 사이의 text 체크하는 정규표현식
        let passwordReg = ("(?=.*[A-Za-z])(?=.*[0-9]).{8,16}")
        let passwordRegTest = NSPredicate(format: "SELF MATCHES %@", passwordReg)
        return passwordRegTest.evaluate(with: self)
        
    }
}

