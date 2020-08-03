//
//  LearnDetailViewController.swift
//  SPI_Language
//
//  Created by 長澤　賢汰 on 2020/07/26.
//  Copyright © 2020 ritsuya. All rights reserved.
//

import UIKit
import Firebase

class LearnDetailViewController: UIViewController {
    
    @IBOutlet weak var numLabel:UILabel!
    @IBOutlet weak var questionImageView:UIImageView!

    var selectedQuestion:questionModel?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setQuestion()
    }
    
    func setQuestion(){
        if let selectedQuestion = selectedQuestion{
            numLabel.text = selectedQuestion.questionNumber?.description
            let url = selectedQuestion.questionContent!
            questionImageView.image = UIImage(url: url)
        }else{
            print("error at LD")
        }
    }

}


