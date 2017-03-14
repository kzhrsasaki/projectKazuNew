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
        
        var totalScore: Int = 0


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
        
        //月初の日付を取得するための定義
        var comp2 = calendar.dateComponents([ .year, .month, .day, .hour, .minute, .second], from: NSDate() as Date)
        
        // ここで1日の0時0分0秒に設定（今月の1日）
        comp2.day = 1
        comp2.hour = 0
        comp2.minute = 0
        comp2.second = 0
        
        // 月初（６ヶ月分）の日付を取得
        var monthOfFirstDay = calendar.date(from: comp2)
        
        var monthOfFirstDay2 = calcDate(year:0,month:-1,day:0,hour:0,minute:0,second:0,baseDate: monthOfFirstDay!)
        
        var monthOfFirstDay3 = calcDate(year:0,month:-1,day:0,hour:0,minute:0,second:0,baseDate: monthOfFirstDay2)
        
        var monthOfFirstDay4 = calcDate(year:0,month:-1,day:0,hour:0,minute:0,second:0,baseDate: monthOfFirstDay3)
        
        var monthOfFirstDay5 = calcDate(year:0,month:-1,day:0,hour:0,minute:0,second:0,baseDate: monthOfFirstDay4)
        
        var monthOfFirstDay6 = calcDate(year:0,month:-1,day:0,hour:0,minute:0,second:0,baseDate: monthOfFirstDay5)
        
        
//        todoListForView = NSArray() as! [NSDictionary]
        for todo in todoListForView{
            print(todo)
            
            let appDelegate: AppDelegate = UIApplication.shared.delegate as! AppDelegate
            
            // scoreの表示
            var completeFlag = todo["complete"] as! Bool
            var score = 0
            
            if (completeFlag == true){
                score = todo["score"] as! Int
                
            } else {
                score = 0
            }
            
                totalScore += score
            
            if (calendar.dateComponents([.day], from: sunday, to: todo["dueDate"] as! Date).day! >= 0) {
                
                thisWeekScore += score
                
            }
            if (calendar.dateComponents([.day], from: sunday2, to: todo["dueDate"] as! Date).day! >= 0) {
                
                oneWeekAgScore += score
                
            }
            if (calendar.dateComponents([.day], from: sunday3, to: todo["dueDate"] as! Date).day! >= 0) {
                
                twoWeekAgScore += score
                
            }
            if (calendar.dateComponents([.day], from: sunday4, to: todo["dueDate"] as! Date).day! >= 0) {
            
                threeWeekAgScore += score
            }
            if (calendar.dateComponents([.day], from: monthOfFirstDay!, to: todo["dueDate"] as! Date).day! >= 0) {
                
                thisMonthScore += score            }
            if (calendar.dateComponents([.day], from: monthOfFirstDay2, to: todo["dueDate"] as! Date).day! >= 0) {
                
                oneMonthAgScore += score            }
            if (calendar.dateComponents([.day], from: monthOfFirstDay3, to: todo["dueDate"] as! Date).day! >= 0) {
                
                twoMonthAgScore += score
            }
            if (calendar.dateComponents([.day], from: monthOfFirstDay4, to: todo["dueDate"] as! Date).day! >= 0) {
                
                threeMonthAgScore += score            }
            if (calendar.dateComponents([.day], from: monthOfFirstDay5, to: todo["dueDate"] as! Date).day! >= 0) {
                
                fourMonthAgScore += score            }
            if (calendar.dateComponents([.day], from: monthOfFirstDay6, to: todo["dueDate"] as! Date).day! >= 0) {
                
                fiveMonthAgScore += score
            }
            
        }
        
                totslScoreLabel.text = "合計得点：\(totalScore)点"
    }
    
    //
    func calcDate(year:Int ,month:Int ,day:Int ,hour:Int ,minute:Int ,second:Int ,baseDate:Date) -> Date {
        
        let calendar = Calendar(identifier: .gregorian)
        var components = DateComponents()
        
        components.setValue(year,for: Calendar.Component.year)
        components.setValue(month,for: Calendar.Component.month)
        components.setValue(day,for: Calendar.Component.day)
        components.setValue(hour,for: Calendar.Component.hour)
        components.setValue(minute,for: Calendar.Component.minute)
        components.setValue(second,for: Calendar.Component.second)
        
        return calendar.date(from: components)!

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
                
                //削除したデータを取り除く
                
                
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
                        cell.periodScoreLabel.text = "\(twoWeekAgScore - oneWeekAgScore)点"
                    case 3:
                        cell.periodLabel.text = "3週前"
                        cell.periodScoreLabel.text = "\(threeWeekAgScore - twoWeekAgScore)点"
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
                        cell.periodScoreLabel.text = "\(twoMonthAgScore - oneMonthAgScore)点"
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
