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
    
    // inputDateは　yyyy/MM/dd mm:ssまで（配列のkeyデータとするため）
    
    // dueDateは　MM/ddまで
    
    // "\(score)点" 、scoreは、completeが”未了”の場合は"0点"、「完了登録」ボタンが表示されている間は”未"、"済み”の場合はsecondViewContollerでの取得データ通り
    
    // reChallenge は　score == 0 && complete == true の場合のみ、アクティブ
    // reChallengeを選択すると、そのデータについてのみ、上書きされる。inputDateは今の時刻になる。
    
    // complete は　ユーザーが自分で登録した場合は"済み"、期限内でユーザーがまだ登録していない場合は"完了登録ボタン"を表示、完了せずに現在の日付 > dueDate の場合は"未了"の表示
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
