//
//  fourthViewController.swift
//  projectKazu
//
//  Created by Apple on 2017/02/15.
//  Copyright © 2017年 Sasaki Kazuhiro. All rights reserved.
//

import UIKit
import CoreData

class fourthViewController: UIViewController,UITableViewDataSource, UITableViewDelegate {
    
    
    @IBOutlet weak var totslScoreLabel: UILabel!
    
    @IBOutlet weak var periodTableView: UITableView!
    
    // Tableで使用する配列を定義する
    let myWeeks:NSArray = ["今週","1週前","2週前","3週前",]
    
    let myMonths:NSArray = ["今月","1ヶ月前","2ヶ月前","3ヶ月前","4ヶ月前","5ヶ月前",]
    
    //個々の行が配列であることの宣言
    var thisWeek:NSArray = []
    var oneWeekAg:NSArray = []
    var twoWeekAg:NSArray = []
    var threeWeekAg:NSArray = []
    var thisMonth:NSArray = []
    var oneMonthAg:NSArray = []
    var twoMonthAg:NSArray = []
    var threeMonthAg:NSArray = []
    var fourMonthAg:NSArray = []
    var fiveMonthAg:NSArray = []
    
    // Sectionで使用する配列を定義する
    let mySections:NSArray = ["週別成績（4週)","月別成績(6か月）"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        var totalScore: Int = 100
        totslScoreLabel.text = "合計得点：\(totalScore)点"
        
        // セルの行ごとにスコアの計算ロジックに基づいて定義
        var thisWeekScore: Int = 6
        let thisWeek:NSArray = ["今週","週間スコア:\(thisWeekScore)点"]
        
        var oneWeekAgScore: Int = 7
        let oneWeekAg:NSArray = ["1週前","週間スコア:\(oneWeekAgScore)点"]
        
        var twoWeekAgScore: Int = 6
        let twoWeekAg:NSArray = ["2週前","週間スコア:\(twoWeekAgScore)点"]
        
        var threeWeekAgScore: Int = 5
        let threeWeekAg:NSArray = ["3週前","週間スコア:\(threeWeekAgScore)点"]
        
        var thisMonthScore: Int = 12
        let thisMonth:NSArray = ["今月","月間スコア:\(thisMonthScore)点"]
        
        var oneMonthAgScore: Int = 13
        let oneMonthAg:NSArray = ["1ヶ月前","月間スコア:\(oneMonthAgScore)点"]
        
        var twoMonthAgScore: Int = 14
        let twoMonthAg:NSArray = ["2ヶ月前","月間スコア:\(twoMonthAgScore)点"]
        
        var threeMonthAgScore: Int = 15
        let threeMonthAg:NSArray = ["3ヶ月前","月間スコア:\(threeMonthAgScore)点"]
        
        var fourMonthAgScore: Int = 16
        let fourMonthAg:NSArray = ["4ヶ月前","月間スコア:\(fourMonthAgScore)点"]
        
        var fiveMonthAgScore: Int = 17
        let fiveMonthAg:NSArray = ["5ヶ月前","月間スコア:\(fiveMonthAgScore)点"]

    }
    
    //セクションの数を返す
    func numberOfSections(in tableView: UITableView) -> Int {
        return mySections.count
    }
    //セクションのタイトルを返す
        func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
            return mySections[section] as? String
    }
    //画面が開いた際に呼び出される
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.section == 0 {
            print("Value: \(myWeeks[indexPath.row])")
//            switch indexPath.row {
//            case 0:
//                myWeeks[indexPath.row] = thisWeek
//            case 1:
//                myWeeks[indexPath.row] = oneWeekAg
//            case 2:
//                myWeeks[indexPath.row] = twoWeekAg
//            case 3:
//                myWeeks[indexPath.row] = threeWeekAg
//            default:
//                false
//            }

        } else if indexPath.section == 1 {
            print("Value: \(myMonths[indexPath.row])")
//            switch indexPath.row {
//            case 0:
//                myMonths[indexPath.row] = thisMonth
//            case 1:
//                myMonths[indexPath.row] = oneMonthAg
//            case 2:
//                myMonths[indexPath.row] = twoMonthAg
//            case 3:
//                myMonths[indexPath.row] = threeMonthAg
//            case 4:
//                myMonths[indexPath.row] = MonthAg
//            default:
//                false
//                
//            }
            
        }
    }
    //テーブルに表示する配列の総数を返す
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return myWeeks.count
            
        } else if section == 1 {
            return myMonths.count
        } else {
            
            return 0
        }
    }
    
    //セルに値を設定する
            func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
                    
                let cell = tableView.dequeueReusableCell(withIdentifier: "myCell", for: indexPath)
                    
                if indexPath.section == 0 {
                        cell.textLabel?.text = "\(myWeeks[indexPath.row])"

                } else if indexPath.section == 1 {
                        cell.textLabel?.text = "\(myMonths[indexPath.row])"
                }
                return cell
            }

                
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
