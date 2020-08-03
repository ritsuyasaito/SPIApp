//
//  StudyHomeViewController.swift
//  SPI_Language
//
//  Created by 長澤　賢汰 on 2020/07/10.

//  Copyright © 2020 ritsuya. All rights reserved.
//

import UIKit

class StudyHomeViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {
    
    @IBOutlet weak var listTableView:UITableView!
    
    let contentList:[String] = ["2語の関係","熟語の意味","語句の用法","並び替え","空欄補充","長文読解"]
    
    let contentPath:[String] = ["two-words","word-meanings","word-usages","word-sorts","fill-blanks","sentence-readings"]

    override func viewDidLoad() {
        listTableView.delegate = self
        listTableView.dataSource = self
        super.viewDidLoad()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return contentList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = listTableView.dequeueReusableCell(withIdentifier: "cell",for: indexPath) as! UITableViewCell
        cell.textLabel?.text = contentList[indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        performSegue(withIdentifier: "toDetail", sender: indexPath)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toDetail"{
            let nextVC = segue.destination as! testpageViewController
            let selectedPath = listTableView.indexPathForSelectedRow!
            nextVC.contentName = contentPath[selectedPath.row]
        }else{
            print("error")
        }
    }

}
