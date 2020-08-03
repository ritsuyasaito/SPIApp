//
//  SegueManagerViewController.swift
//  SPI_Language
//
//  Created by 長澤　賢汰 on 2020/07/11.
//  Copyright © 2020 ritsuya. All rights reserved.
//

import UIKit

struct SegueManager {
    
    enum DisplayType{
        case main
        case login
    }
    
    static func show(displayType: DisplayType) {
        
        guard let windowScene = UIApplication.shared.connectedScenes
                    .first(where: { $0.activationState == .foregroundActive }) as? UIWindowScene else { return }
        guard let keywindow = windowScene.windows.first(where:{$0.isKeyWindow}) else {return}
        
        
        // 引数で選ばれた画面によって遷移
        switch displayType {

        case .login:
            // ログイン画面のStoryboardを取得してウィンドウを差し替え
           let storyboard = UIStoryboard(name: "Login", bundle: Bundle.main)
            let rootViewController = storyboard.instantiateViewController(withIdentifier: "RootNavigationController")
            keywindow.rootViewController = rootViewController
            keywindow.backgroundColor = UIColor.white
            keywindow.makeKeyAndVisible()

        case .main:
            // MainのStoryboardを取得してウィンドウを差し替え
            let storyboard = UIStoryboard(name: "Main", bundle: Bundle.main)
            let rootViewController = storyboard.instantiateViewController(withIdentifier: "RootTabBarController")
            keywindow.rootViewController = rootViewController
            keywindow.backgroundColor = UIColor.white
            keywindow.makeKeyAndVisible()
        }
    }

    
    
}

extension UIApplication {
    var windowScene: UIWindowScene? {
        return connectedScenes
            .first(where: { $0.activationState == .foregroundActive }) as? UIWindowScene
    }

    // keyWindowは以下のように取得できます。
    var keyWindow: UIWindow? {
        return windowScene?.windows
            .first(where: { $0.isKeyWindow })
    }
}
