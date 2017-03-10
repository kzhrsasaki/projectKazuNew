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
    
    //辞書配列の定義（見るだけ）
    var todoListForView:[NSDictionary] = []

    
    // Tableで使用する配列を定義する
    let myWeeks:NSArray = ["今週","1週前","2週前","3週前",]
    
    let myMonths:NSArray = ["今月","1ヶ月前","2ヶ月前","3ヶ月前","4ヶ月前","5ヶ月前",]
    
    // Sectionで使用する配列を定義する
    let mySections:NSArray = ["週別成績（4週)","月別成績(6か月）"]
    
    var thisWeekScore: Int = 0
    var oneWeekAgScore: Int = 0
    var twoWeekAgScore: Int = 0
    var threeWeekAgScore: Int = 0
    var thisMonthScore: Int = 0
    var oneMonthAgScore: Int = 0
    var twoMonthAgScore: Int = 0
    var threeMonthAgScore: Int = 0
    var fourMonthAgScore: Int = 0
    var fiveMonthAgScore: Int = 0
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        var totalScore: Int = 100
        
        
        
        totslScoreLabel.text = "合計得点：\(totalScore)点"
        //Coredataからのdataを読み込む処理（後で関数を定義）
        read()
        
        // セルの行ごとにスコアの計算ロジックに基づいて定義
        thisWeekScore = 6

        
        oneWeekAgScore = 7

        
        twoWeekAgScore = 6

        
        threeWeekAgScore = 5

        
        thisMonthScore = 12

        
        oneMonthAgScore = 13

        
        twoMonthAgScore = 14

        
        threeMonthAgScore = 15

        
        fourMonthAgScore = 16

        
        fiveMonthAgScore = 17


    }
    
    //既に存在するデータの読み込み
    func read(){
        
        //AppDelegateを使う
        let appDelegate: AppDelegate = UIApplication.shared.delegate as! AppDelegate
        
        //エンティティを操作するためのオブジェクトを作成
        let viewContext = appDelegate.persistentContainer.viewContext
        
        //どのエンティティからdataを取得してくるか設定
        let query: NSFetchRequest<ToDo> = ToDo.fetchRequest()
        
        do{
            //データを一括取得
            let fetchResults = try viewContext.fetch(query)
            
            //データを一件ずつ取得(result)
            for result: AnyObject in fetchResults{
                let inputDate: Date? = result.value(forKey: "inputDate") as? Date
                let dueDate: Date? = result.value(forKey: "dueDate") as? Date
                let myTitle: String? = result.value(forKey: "myTitle") as? String
                let score: Int?  = result.value(forKey: "score") as? Int
                let complete: Bool? = result.value(forKey: "complete") as? Bool
                let reChallenge: Bool? = result.value(forKey: "reChallenge") as? Bool
                let myContents: String? = result.value(forKey: "myContents") as? String
                let memo: String? = result.value(forKey: "memo") as? String
                
                //データを配列に追加する。どうやって？
                todoListForView.append(["inputDate":inputDate,"dueDate":dueDate,"myTitle":myTitle,"score":score,"complete":complete,"reChallenge":reChallenge,"myContents":myContents,"memo":memo])
                
               }
           } catch {
           }


    }

    
    
    let date: NSDate = NSDate()
    let cal: NSCalendar = NSCalendar(identifier: NSCalendar.Identifier.gregorian)!
    let comp: NSDateComponents = cal.components([NSCalendar.Unit.Weekday], fromDate: .date）
    
    let weekday: Int = comp.weekday
    
    
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

        } else if indexPath.section == 1 {
            print("Value: \(myMonths[indexPath.row])")
            
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
                    
                let cell = tableView.dequeueReusableCell(withIdentifier: "myCell", for: indexPath) as! ScoreTableViewCell
                
                if indexPath.section == 0 {
                        //cell.textLabel?.text = "\(myWeeks[indexPath.row])"
                    switch indexPath.row {
                    case 0:
                        cell.periodLabel.text = "今週"
                        cell.periodScoreLabel.text = "\(thisWeekScore)点"
                    case 1:
                        cell.periodLabel.text = "1週前"
                        cell.periodScoreLabel.text = "\(oneWeekAgScore)点"
                    case 2:
                        cell.periodLabel.text = "2週前"
                        cell.periodScoreLabel.text = "\(twoWeekAgScore)点"
                    case 3:
                        cell.periodLabel.text = "3週前"
                        cell.periodScoreLabel.text = "\(threeWeekAgScore)点"
                    default: break
                        
                    }

                } else if indexPath.section == 1 {
                        //cell.textLabel?.text = "\(myMonths[indexPath.row])"
                    switch indexPath.row {
                    case 0:
                        cell.periodLabel.text = "今月"
                        cell.periodScoreLabel.text = "\(thisMonthScore)点"
                    case 1:
                        cell.periodLabel.text = "1ヶ月前"
                        cell.periodScoreLabel.text = "\(oneMonthAgScore)点"
                    case 2:
                        cell.periodLabel.text = "2ヶ月前"
                        cell.periodScoreLabel.text = "\(twoMonthAgScore)点"
                    case 3:
                        cell.periodLabel.text = "3ヶ月前"
                        cell.periodScoreLabel.text = "\(threeMonthAgScore)点"
                    case 4:
                        cell.periodLabel.text = "4ヶ月前"
                        cell.periodScoreLabel.text = "\(fourMonthAgScore)点"
                    case 5:
                        cell.periodLabel.text = "5ヶ月前"
                        cell.periodScoreLabel.text = "\(fiveMonthAgScore)点"
                    default: break
                    }
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
