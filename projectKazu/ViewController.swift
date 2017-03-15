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
            notification.alertTitle = "TODO登録のご案内"
            //通知メッセージ
            notification.alertBody = "TODOが完了したら「履歴・完了登録画面」にて完了入力しましょう！"
            //Timezoneの設定
            notification.timeZone = TimeZone.current
            
            //フォーマットを設定
            //let df = DateFormatter()
            //df.dateFormat = "yy/MM/dd HH:mm:ss"

            
            //毎日17時00分に通知を設定
            //notification.fireDate = Date(timeInterval: 61200, since: date(from: df.string(from: NSDate() as Date) + " 00:00:00")!)
            
            // 通知設定
            let now = NSDate() as Date
            print(now)
            let calendar = NSCalendar(identifier: NSCalendar.Identifier.gregorian)
            let comps:NSDateComponents = calendar!.components([NSCalendar.Unit.year, .month, .day, .hour, .minute], from: now) as NSDateComponents
            comps.timeZone = TimeZone.current
            comps.calendar = calendar as Calendar?
            comps.hour = 12
            comps.minute = 14
            
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

