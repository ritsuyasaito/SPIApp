//
//  FailedQuestionsViewController.swift
//  SPI_Language
//
//  Created by 長澤　賢汰 on 2020/07/27.
//  Copyright © 2020 ritsuya. All rights reserved.
//

import UIKit

class FailedQuestionsViewController: UIViewController {
    
    @IBOutlet weak var listTableView:UITableView!
    
    var questionFailed = [String](){
        didSet{
            listTableView.reloadData()
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setdata()
        listTableView.delegate = self
        listTableView.dataSource = self
    }
    
    func setdata(){
        userModel.setfailed { (user) in
        if let user = user {
            self.questionFailed = user.failedQuestionsID
        }else{
            //間違った問題がない表示
            
            }
        }
    }
    
    
}

extension FailedQuestionsViewController:UITableViewDataSource,UITableViewDelegate{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return questionFailed.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = listTableView.dequeueReusableCell(withIdentifier: "failedcell") as! UITableViewCell
        DispatchQueue.main.async {
            cell.textLabel?.text = self.questionFailed[indexPath.row]
        }
        return cell
    }
    
}
