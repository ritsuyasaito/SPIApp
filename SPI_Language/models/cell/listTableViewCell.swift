//
//  listTableViewCell.swift
//  SPI_Language
//
//  Created by 長澤　賢汰 on 2020/07/15.
//  Copyright © 2020 ritsuya. All rights reserved.
//

import UIKit

class listTableViewCell: UITableViewCell {
    
    @IBOutlet weak var numberLabel:UILabel!

    
    //初期設定
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func setup(question:questionModel?){
        if let question = question{
            numberLabel.text = question.questionNumber?.description
        }else{
             numberLabel.text = "1"

        }
    }
    
}
