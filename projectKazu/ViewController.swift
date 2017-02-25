//
//  ViewController.swift
//  projectKazu
//
//  Created by Apple on 2017/02/10.
//  Copyright © 2017年 Sasaki Kazuhiro. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var mySwitch: UISwitch!
    
    @IBOutlet weak var enterButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }

    @IBAction func tapSwitch(_ sender: UISwitch) {
        if sender.isOn {
            print("スイッチON")
            //ローカル通知の設定（通知用のオブジェクトを生成）
            let notification:UILocalNotification = UILocalNotification()
            
            //タイトル
            notification.alertTitle = "Fire"
            //通知メッセージ
            notification.alertBody = "ファイヤー！！"
            //Timezoneの設定
            notification.timeZone = TimeZone.current
            //毎日17時00分に通知を設定
            notification.fireDate = Date(timeIntervalSinceNow: 10)
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

