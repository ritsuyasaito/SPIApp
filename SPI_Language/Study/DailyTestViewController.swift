//
//  DailyTestViewController.swift
//  SPI_Language
//
//  Created by 長澤　賢汰 on 2020/07/10.
//  Copyright © 2020 ritsuya. All rights reserved.
//

import UIKit
import Firebase

class DailyTestViewController: UIViewController {
    
    @IBOutlet weak var questionImageView:UIImageView!
    @IBOutlet weak var questionNumberLabel:UILabel!
    @IBOutlet weak var buttonView:UIView!

    //問題番号
    var labelNum = 1
    //完了した問題の数
    var DoneNum = 0
    //正解の数
    var correctSum = 0
    //正解の番号
    var correctNumber:Int!
    //問題の配列
    var questionArray = [questionModel]()
    //問題番号の配列
    var questionNumberArray = [Int]()
    //間違った問題の配列
    var failedQuestions = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setQuestions()
    }
    override func viewWillAppear(_ animated: Bool) {
        navigationController?.setNavigationBarHidden(true, animated: false)
    }
    
    //画面遷移コード
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    if segue.identifier == "toResult" {
            let nextVC = segue.destination as! DailyTestResultViewController
            nextVC.result = correctSum
        }
    }
    
    //問題を読み込む関数
    func setQuestions(){
        //firebasesotrageからデータを読み込み、UIViewに表示
        questionModel.getAll { (questions) in
            if let questions = questions {
                self.questionArray = self.questionArray + questions
            }else{
                print("loading error")
            }
            DispatchQueue.main.async {
                //UIにデータをセット
                self.questionNumberLabel.text = self.labelNum.description
                if let url = self.questionArray[self.DoneNum].questionContent{
                    self.questionImageView.image = UIImage(url: url)
                }
                }
    }
    }
    
    //実行を制御する関数
   @IBAction func answered(sender:UIButton){
    if sender.tag == questionArray[self.DoneNum].correctNumber{
            correctSum += 1
            //○と表示するコード
            
        }else{
        failedQuestions.append(questionArray[self.DoneNum].questionID!)
            //✗と表示するコード
        }
        DoneNum += 1
        labelNum += 1
        if DoneNum < 10{
            setQuestions()
        }else{
            userModel.save(failedQuestions) { (error) in
                if let error = error{
                    //エラー処理
                    print("error")
                }else{
                    print("succes")
                }
            }
          //画面遷移コード
          performSegue(withIdentifier: "toResult", sender:nil)
        }
 }
//
}

extension UIImage {
    public convenience init(url: String) {
        let url = URL(string: url)
        do {
            let data = try Data(contentsOf: url!)
            self.init(data: data)!
            return
        } catch let err {
            print("Error : \(err.localizedDescription)")
        }
        self.init()
    }
}
