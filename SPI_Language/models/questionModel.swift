//
//  questionModel.swift
//  SPI_Language
//
//  Created by 長澤　賢汰 on 2020/07/10.
//  Copyright © 2020 ritsuya. All rights reserved.
//

import UIKit
import Firebase


struct questionModel {
    
    var questionID:String?
    var questionNumber:Int?
    var correctNumber:Int?
    var questionContent:String?
    
    static func getAll(completion:@escaping(_ questions:[questionModel]?) -> ()){
        let ref = Firestore.firestore()
        ref.collection("two-words").getDocuments { (snapshot, error) in
            if let error = error {
                print("Dyanamic error")
            }else{
                if let documents = snapshot?.documents{
                    var questions = [questionModel]()
                    for document in documents{
                        let data = document.data()
                        var question = questionModel()
                        question.questionID = data["questionID"] as! String
                        question.questionNumber = data["questionNumber"] as! Int
                        question.correctNumber = data["correctNumber"] as! Int
                        if data["questionContent"] != nil{
                        question.questionContent = data["questionContent"] as! String
                        }else{
                            print("contentなし")
                        }
                        questions.append(question)
                    }
                    completion(questions)
                }else{
                    completion(nil)
                }
            }
        }
    }
    
    static func getOne(_ collection:String,completion:@escaping(_ questions:[questionModel]?) -> ()){
        let ref = Firestore.firestore()
        ref.collection(collection).getDocuments { (snapshot, error) in
            if let error = error {
                print("Dyanamic error")
            }else{
                if let documents = snapshot?.documents{
                    var questions = [questionModel]()
                    for document in documents{
                        let data = document.data()
                        var question = questionModel()
                        question.questionID = data["questionID"] as! String
                        question.questionNumber = data["questionNumber"] as! Int
                        question.correctNumber = data["correctNumber"] as! Int
                        if data["questionContent"] != nil{
                        question.questionContent = data["questionContent"] as! String
                        }else{
                            print("contentなし")
                        }
                        questions.append(question)
                    }
                    completion(questions)
                }else{
                    completion(nil)
                }
            }
        }
    }
    
}

 
