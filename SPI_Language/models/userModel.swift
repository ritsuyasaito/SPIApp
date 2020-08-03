//
//  userModel.swift
//  SPI_Language
//
//  Created by 長澤　賢汰 on 2020/07/10.
//  Copyright © 2020 ritsuya. All rights reserved.
//

import UIKit
import Firebase

struct userModel{
    
    var userId:String?
    var displayName:String?
    var failedQuestionsID = [String]()
    
    // ログイン中のユーザーを取得するメソッド
    static func currentUser() -> userModel? {

        if let currentUser = Auth.auth().currentUser {
            var user = userModel()
            user.userId = currentUser.uid
            user.displayName = currentUser.displayName
            return user
        } else {
            return nil
        }
    }

    // ログイン中のユーザーがいるかどうか確認し、ログインしていなければログイン画面に飛ばすメソッド
    static func validateCurrentUser() {
        if let _ = userModel.currentUser() {
            SegueManager.show(displayType: .main)
        } else {
            SegueManager.show(displayType: .login)
        }
    }
    
    // 会員登録
    static func signUp(email: String, password: String, completion: @escaping(Error?) -> ()) {
        Auth.auth().createUser(withEmail: email, password: password) { (result, error) in
            completion(error)
        }
    }
    
    // ログイン
    static func login(email: String, password: String, completion: @escaping(Error?) -> ()) {
        Auth.auth().signIn(withEmail: email, password: password) { (result, error) in
            completion(error)
        }
    }
    
    static func logout(completion: @escaping(Error?) -> ()) {

        do {
            try Auth.auth().signOut()
        } catch let error {
            completion(error)
        }
    }
    
    //データの登録
    static func save(_ failedArray:[String] ,completion:@escaping (Error?) -> ()){
        guard let user = Auth.auth().currentUser else {return}
        var usermodel = userModel()
        let db = Firestore.firestore()
        db.collection("users").document(user.uid).setData([
            "failedQuestions": failedArray,
            ])
    }
    
    //データの取得
    static func setfailed(completion:@escaping(_ user:userModel?) -> ()){
        var user = userModel()
        guard let currentUser = Auth.auth().currentUser else {return}
        let ref = Firestore.firestore()
        let uid = currentUser.uid
        ref.collection("users").document(uid).getDocument { (snapshot, error) in
            if let error = error {
                //エラー処理
                print("conection error")
            }else{
                guard let snapshot = snapshot, snapshot.exists, let data = snapshot.data() else {
                // データがないときの処理
                return
                }
                user.failedQuestionsID += data["failedQuestions"] as! Array<String>
            }
                    completion(user)
                }
            }

}
