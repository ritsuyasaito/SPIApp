//
//  SignupViewController.swift
//  SPI_Language
//
//  Created by 長澤　賢汰 on 2020/07/11.
//  Copyright © 2020 ritsuya. All rights reserved.
//

import UIKit
import Firebase

class SignupViewController: UIViewController {
    
    @IBOutlet weak var emailTextField:UITextField!
    @IBOutlet weak var passwordTextField:UITextField!

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func signup(){
        guard let email = emailTextField.text else {return}
        guard let password = passwordTextField.text else {return}
        userModel.signUp(email: email, password: password) { (error) in
            if let error = error{
                print("sign up error")
            }else{
               SegueManager.show(displayType: .main)
            }
        }
    
    }
   
}


