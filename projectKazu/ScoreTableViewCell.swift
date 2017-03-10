//
//  ScoreTableViewCell.swift
//  projectKazu
//
//  Created by Apple on 2017/03/10.
//  Copyright © 2017年 Sasaki Kazuhiro. All rights reserved.
//

import UIKit

class ScoreTableViewCell: UITableViewCell {


    @IBOutlet weak var periodLabel: UILabel!
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
