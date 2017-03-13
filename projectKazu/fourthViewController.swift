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
    
    // スコア集計に必要となる配列を定義
    var thisWeek:NSArray = []
    var oneWeekAg:NSArray = []
    var twoWeekAg:NSArray = []
    var threeWeekAg:NSArray = []
    
    var firstMonthDay1:Date = Date()
    var firstMonthDay2:Date = Date()
    var firstMonthDay3:Date = Date()
    var firstMonthDay4:Date = Date()
    var firstMonthDay5:Date = Date()
    var firstMonthDay6:Date = Date()
    
    var thisMonthAg:NSArray = []
    var oneMonthAg:NSArray = []
    var twoMonthAg:NSArray = []
    var threeMonthAg:NSArray = []
    var fourMonthAg:NSArray = []
    var fiveMonthAg:NSArray = []
    //期間ごとのスコアを定義
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
                
        //今日から7日未満の差の日付（hh:mm:ssを00:00:00に換算）で日曜から配列を定義し、配列の日付に係るscoreを合計
        
        let calendar = Calendar(identifier: .gregorian)
        //今日の日付が何曜日かを算出（日曜日が1、土曜日が7）
        let comp = Calendar.Component.weekday
        var weekday = NSCalendar.current.component(comp, from: NSDate() as Date)
        
        
        var diffDateNum = weekday - 1
        
        var sunday = Date(timeInterval: TimeInterval(Int(-86400*diffDateNum)), since: NSDate() as Date)
        
        var sunday2 = Date(timeInterval: TimeInterval(Int(-86400*(diffDateNum + 7 ))), since: NSDate() as Date)
        
        var sunday3 = Date(timeInterval: TimeInterval(Int(-86400*(diffDateNum + 14 ))), since: NSDate() as Date)
        
        var sunday4 = Date(timeInterval: TimeInterval(Int(-86400*(diffDateNum + 21 ))), since: NSDate() as Date)
        
//        todoListForView = NSArray() as! [NSDictionary]
        for todo in todoListForView{
            print(todo)
            
            let appDelegate: AppDelegate = UIApplication.shared.delegate as! AppDelegate
            
            if (calendar.dateComponents([.day], from: sunday, to: todo["dueDate"] as! Date).day! >= 0) {
                
                thisWeekScore += todo["score"] as! Int
                
            }
            if (calendar.dateComponents([.day], from: sunday2, to: todo["dueDate"] as! Date).day! >= 0) {
                
                oneWeekAgScore += todo["score"] as! Int
                
            }
            if (calendar.dateComponents([.day], from: sunday3, to: todo["dueDate"] as! Date).day! >= 0) {
                
                twoWeekAgScore += todo["score"] as! Int
                
            }
            if (calendar.dateComponents([.day], from: sunday4, to: todo["dueDate"] as! Date).day! >= 0) {
            
                threeWeekAgScore += todo["score"] as! Int
            }
                
            
//            if (weekday == 1) {
//                   sunday1 = NSDate() as Date
//            
//            } else if (weekday == 2) {
//                  sunday1 = Date(timeInterval: -86400 * day, since: NSDate() as Date)
//            } else if
        }
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
                
                //データを配列に追加する
              todoListForView.append(["inputDate":inputDate,"dueDate":dueDate,"myTitle":myTitle,"score":score,"complete":complete,"reChallenge":reChallenge,"myContents":myContents,"memo":memo])
                
               }
           } catch {
           }

            
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
                        cell.periodScoreLabel.text = "\(oneWeekAgScore - thisWeekScore)点"
                    case 2:
                        cell.periodLabel.text = "2週前"
                        cell.periodScoreLabel.text = "\(twoWeekAgScore - oneWeekAgScore - thisWeekScore)点"
                    case 3:
                        cell.periodLabel.text = "3週前"
                        cell.periodScoreLabel.text = "\(threeWeekAgScore - twoWeekAgScore - oneWeekAgScore - thisWeekScore)点"
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
                        cell.periodScoreLabel.text = "\(oneMonthAgScore - thisMonthScore)点"
                    case 2:
                        cell.periodLabel.text = "2ヶ月前"
                        cell.periodScoreLabel.text = "\(twoMonthAgScore - thisMonthScore)点"
                    case 3:
                        cell.periodLabel.text = "3ヶ月前"
                        cell.periodScoreLabel.text = "\(threeMonthAgScore - twoMonthAgScore)点"
                    case 4:
                        cell.periodLabel.text = "4ヶ月前"
                        cell.periodScoreLabel.text = "\(fourMonthAgScore - threeMonthAgScore)点"
                    case 5:
                        cell.periodLabel.text = "5ヶ月前"
                        cell.periodScoreLabel.text = "\(fiveMonthAgScore - fourMonthAgScore)点"
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
