//
//  DailyTestResultViewController.swift
//  SPI_Language
//
//  Created by 長澤　賢汰 on 2020/07/10.
//  Copyright © 2020 ritsuya. All rights reserved.
//

import UIKit

class DailyTestResultViewController: UIViewController {
    
    @IBOutlet weak var resultLabel:UILabel!
    
    var result:Int?

    override func viewDidLoad() {
        super.viewDidLoad()
        setResultLabel()
        
    }
    
    func setResultLabel(){
        if let result = result{
            resultLabel.text = String(result * 10)
        }
    }
    
    @IBAction func back(sender:UIButton){
        performSegue(withIdentifier: "backToStudyHome", sender: nil)
    }
    
}
