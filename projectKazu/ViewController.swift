//
//  ViewController.swift
//  projectKazu
//
//  Created by Apple on 2017/02/10.
//  Copyright © 2017年 Sasaki Kazuhiro. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var myImageView: UIImageView!
    @IBOutlet weak var mySwitch: UISwitch!
    
    @IBOutlet weak var enterButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        myImageView.image = UIImage(named: "todoList.png")

    }

    @IBAction func tapSwitch(_ sender: UISwitch) {
        if sender.isOn {
            print("スイッチON")
            //ローカル通知の設定（通知用のオブジェクトを生成）
            let notification:UILocalNotification = UILocalNotification()
            
            //タイトル
            notification.alertTitle = "完了入力のご案内"
            //通知メッセージ
            notification.alertBody = "TODOを達成したら「履歴・完了登録画面」にて完了入力しましょう！"
            //Timezoneの設定
            notification.timeZone = TimeZone.current
            
            // 通知設定
            let now = NSDate() as Date
            print(now)
            
            let calendar = NSCalendar(identifier: NSCalendar.Identifier.gregorian)
            let comps:NSDateComponents = calendar!.components([NSCalendar.Unit.year, .month, .day, .hour, .minute, .second], from: now) as NSDateComponents
            
//            let calendar = Calendar.current            
//            let comps:NSDateComponents = calendar.dateComponents([NSCalendar.Unit.year, .month, .day, .hour, .minute, .second], from: now) as NSDateComponents
//            
            comps.timeZone = TimeZone.current
            comps.calendar = calendar as Calendar?
            comps.hour = 12
            comps.minute = 14
            comps.second = 0
            
            //まだ今日の通知時間が来てないなら今日の日付、すでに過ぎているなら明日の日付
            if now.compare(comps.date!) != .orderedAscending {
                comps.day += 1
            }
            
            let now2 = comps.date
            print(now2!)
            
            notification.fireDate = now2
            
            //毎日繰り返す
            notification.repeatInterval = .day
            
            //Notificationを表示（登録）
            UIApplication.shared.scheduleLocalNotification(notification)
            
        } else {
            print("スイッチOFF")
            false
        }

    
    
    
    }


    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

