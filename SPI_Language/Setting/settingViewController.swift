//
//  settingViewController.swift
//  SPI_Language
//
//  Created by 長澤　賢汰 on 2020/07/10.
//  Copyright © 2020 ritsuya. All rights reserved.
//

import UIKit

class settingViewController: UIViewController {
    
    @IBOutlet weak var userLabel:UILabel?

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    func setDefault(){
        //userLabelにuserNameを入れる
    }
    
    @IBAction func logout(){
        userModel.logout(){(error) in
            if let error = error {
                print("ログアウトエラー")
            }else{
                SegueManager.show(displayType: .login)
            }
        }
        SegueManager.show(displayType: .login)

    }
    
    

}
