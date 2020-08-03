//
//  LearnViewController.swift
//  SPI_Language
//
//  Created by 長澤　賢汰 on 2020/07/14.
//  Copyright © 2020 ritsuya. All rights reserved.
//

import UIKit
import Firebase

class LearnViewController: UIViewController {
    
    @IBOutlet weak var testLabel:UILabel!
    @IBOutlet weak var listTableView:UITableView!
    
    //値を受ける
    var contentName:String!
    //問題の配列（ここで読み込んだデータをストック）
    var questionsArray = [questionModel](){
        didSet{
            listTableView.reloadData()
        }
    }
    
    override func viewDidLoad(){
        super.viewDidLoad()
        testLabel.text = contentName
        loadData()
        configureTableView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
           navigationController?.setNavigationBarHidden(false, animated: false)
       }
    
    func configureTableView() {
            listTableView.dataSource = self
            listTableView.delegate = self
                   // カスタムセルの登録
                   let nib = UINib(nibName: "listTableViewCell", bundle: Bundle.main)
            listTableView.register(nib, forCellReuseIdentifier: "CELL")
    }
    
    func loadData(){
        questionModel.getOne(contentName) { (questions) in
            if let questions = questions{
                self.questionsArray.append(contentsOf: questions)
            }else{
                //仮置している（エラー処理を作りたい)
                print("error")
            }
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
            performSegue(withIdentifier: "toEx", sender: nil)
        listTableView.deselectRow(at: indexPath, animated: true)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toEx" {
            let NextVC = segue.destination as! LearnDetailViewController
            let selectedIndexpath = listTableView.indexPathForSelectedRow!
            NextVC.selectedQuestion = questionsArray[selectedIndexpath.row]
        }else{
            //エラー処理
            print("遷移ミス")
        }
    }
    
}

extension LearnViewController:UITableViewDataSource,UITableViewDelegate{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return questionsArray.count
          }
          
       func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
              let cell = listTableView.dequeueReusableCell(withIdentifier: "CELL",for:indexPath) as! listTableViewCell
        DispatchQueue.main.async {
            print(self.questionsArray)
            cell.setup(question:self.questionsArray[indexPath.row])
        }
        return cell
    }
}
