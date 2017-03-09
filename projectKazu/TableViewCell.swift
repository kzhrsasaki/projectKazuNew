//
//  TableViewCell.swift
//  projectKazu
//
//  Created by Apple on 2017/02/21.
//  Copyright © 2017年 Sasaki Kazuhiro. All rights reserved.
//

import UIKit

class TableViewCell: UITableViewCell {
    
    //セル内の項目を定義
    @IBOutlet weak var inputDateLabel: UILabel!
    @IBOutlet weak var dueDateLabel: UILabel!
    @IBOutlet weak var myTitleLabel: UILabel!
    @IBOutlet weak var scoreLabel: UILabel!
    @IBOutlet weak var reChallengeButton: UIButton!
    @IBOutlet weak var completeButton: UIButton!
    @IBOutlet weak var detailButton: UIButton!

    @IBOutlet weak var periodScoreLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
