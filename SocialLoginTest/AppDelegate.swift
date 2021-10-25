//
//  AppDelegate.swift
//  SocialLoginTest
//
//  Created by 이성근 on 2021/10/17.
//

import UIKit
import FirebaseAuth
import KakaoSDKCommon
import KakaoSDKAuth
import Firebase
import GoogleSignIn

@main
class AppDelegate: UIResponder, UIApplicationDelegate , GIDSignInDelegate {

    private let kakaoKey = "835ab714b72088b4c7a66b038d948423"

    func sign(_ signIn: GIDSignIn!, didSignInFor user: GIDGoogleUser!, withError error: Error!) {
        // loign Action
        if let err = error {
            print("Error -> \(err.localizedDescription)")
            return
        }

        guard let authentication = user.authentication else {return} // 유저인증
        let credential = GoogleAuthProvider.credential(withIDToken: authentication.idToken, accessToken: authentication.accessToken) // 권한 위임
        Auth.auth().signIn(with: credential) {
            if let error = $1 {
                print("Error -> \(error.localizedDescription)")
            }
            // 화면이동할 소스 추가
        }
    }

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        FirebaseApp.configure()

        GIDSignIn.sharedInstance().clientID = FirebaseApp.app()?.options.clientID   // cliend ID 추가
        GIDSignIn.sharedInstance().delegate = self // 델리게이트 셋

        KakaoSDKCommon.initSDK(appKey: kakaoKey)
        return true
    }

    func application(_ app: UIApplication, open url: URL, options: [UIApplication.OpenURLOptionsKey : Any] = [:]) -> Bool {
        if (AuthApi.isKakaoTalkLoginUrl(url)) {
            // KaKao Login
            return AuthController.handleOpenUrl(url: url)
        }else if (GIDSignIn.sharedInstance().handle(url)) {
            // google Login
            return GIDSignIn.sharedInstance().handle(url)
        }
        return false
    }

    // MARK: UISceneSession Lifecycle

    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        // Called when a new scene session is being created.
        // Use this method to select a configuration to create the new scene with.
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }

    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
        // Called when the user discards a scene session.
        // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
        // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
    }


}

