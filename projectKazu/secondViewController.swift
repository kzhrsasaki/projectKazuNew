//
//  secondViewController.swift
//  projectKazu
//
//  Created by Apple on 2017/02/15.
//  Copyright © 2017年 Sasaki Kazuhiro. All rights reserved.
//

import UIKit
import CoreData

class secondViewController: UIViewController, UITextFieldDelegate,UITextViewDelegate {

    @IBOutlet weak var formView: UIView!

    @IBOutlet weak var myLabel1: UILabel!
    @IBOutlet weak var myLabel2: UILabel!
    @IBOutlet weak var myTitle: UITextField!
    @IBOutlet weak var myContents: UITextView!
    
    @IBOutlet weak var mySwitch: UISwitch!
    
    //辞書配列の定義（文字列で良いか？）
    var todoList:[String] = NSArray() as! [String]
    
    //scoreのメンバー変数化
    var score:Int = 1
    
    //segueでthirdViewControllerから引き継ぐ
    var scSelectedTitle = ""
    var scSelectedContents = ""
    

    
    override func viewDidLoad() {
        super.viewDidLoad()
    
    //「再チャレンジ」でthirdViewControllerからセグエで推移
        myTitle.text = scSelectedTitle
        myContents.text = scSelectedContents
        
        //現在時刻を取得
        let myDate: Date = Date()
        
        //カレンダーを取得
        let myCalendar: NSCalendar = NSCalendar(calendarIdentifier: NSCalendar.Identifier.gregorian)!
        
        //取得するコンポーネントを決める
        let myComponetns1 = myCalendar.components(
            [NSCalendar.Unit.year,NSCalendar.Unit.month,NSCalendar.Unit.day,NSCalendar.Unit.weekday],
            from: myDate)
        
        let weekdayStrings: Array = ["nil","日","月","火","水","木","金","土"]
        
        print("year: \(myComponetns1.year)")
        print("month: \(myComponetns1.month)")
        print("day: \(myComponetns1.day)")
        print("weekday: \(weekdayStrings[myComponetns1.weekday!])")
        
        //現在時間表示用のラベルを生成.
        //今日の日時・曜日をラベルに表示
        var myStr1: String = "今日は、" + "\(myComponetns1.year!)年" + "\(myComponetns1.month!)月" + "\(myComponetns1.day!)日[" + "\(weekdayStrings[myComponetns1.weekday!])]" + "です！"
        
        myLabel1.text = myStr1
        
        //明日の日時・曜日をラベルに表示
        //24時間後の時刻を取得
        let myDate2 = NSDate(timeInterval: 60 * 60 * 24 * 1, since: myDate)
        
        //取得するコンポーネントを決める.
        let myComponetns2 = myCalendar.components(
            [NSCalendar.Unit.year,NSCalendar.Unit.month,NSCalendar.Unit.day,NSCalendar.Unit.weekday],
            from: myDate2 as Date)
        
        let weekdayStrings2: Array = ["nil","日","月","火","水","木","金","土"]

        var myStr2: String = "明日は、" + "\(myComponetns2.year!)年" + "\(myComponetns2.month!)月" + "\(myComponetns2.day!)日[" + "\(weekdayStrings2[myComponetns2.weekday!])]" + "です！"
        myLabel2.text = myStr2
        
        //キーボードの上に「閉じる」ボタンを配置 （closeKeyBoardメソッドを下段に先に書いておく）
        //ビューを作成
        let upView = UIView()
        upView.frame.size.height = 35 //高さ指定
        upView.backgroundColor = UIColor.lightGray
        
        //閉じるボタンを右上に作成
        let closeButton = UIButton(frame: CGRect(x: self.view.bounds.width - 70, y: 0, width: 70, height: 30))
        closeButton.setTitle("閉じる", for: .normal)
        
        //閉じるボタンにイベントを設定
        closeButton.addTarget(self, action: #selector(closeKeyBoard(sender:)), for: .touchUpInside)
        
        //ビューに閉じるボタンを追加
        upView.addSubview(closeButton)
        
        //キーボードのアクセサリービューを設定
        myContents.inputAccessoryView = upView
        
        //switchの初期値を「いいえ」にしておく
        mySwitch.isOn = false
        
    }
    
    // 登録ボタンが押された時にデータを新規登録する
    @IBAction func tapResister(_ sender: UIButton) {
        //AppDelegateを使う用意をしておく
        let appDelegate: AppDelegate = UIApplication.shared.delegate as! AppDelegate
        
        //エンティティを操作するためのオブジェクトを作成
        let viewContext = appDelegate.persistentContainer.viewContext
        
        //ToDoエンティティオブジェクトの作成（SQL文とは異なる、オブジェクト指向）
        let ToDo = NSEntityDescription.entity(forEntityName: "ToDo", in: viewContext)
        
        //ToDoエンティティにレコード（行）を挿入するためのオブジェクトを作成
        let newRecord = NSManagedObject(entity: ToDo!, insertInto: viewContext)
        
        //カレンダーを取得
        let myCalendar: NSCalendar = NSCalendar(calendarIdentifier: NSCalendar.Identifier.gregorian)!
        
        //24時間後の時刻を取得
        let myDate2 = NSDate(timeInterval: 60 * 60 * 24 * 1, since: Date())
        
        //値のセット
        newRecord.setValue(Date(), forKey: "inputDate")
        newRecord.setValue(myDate2, forKey: "dueDate")
        newRecord.setValue(myTitle.text, forKey: "myTitle")
        newRecord.setValue(myContents.text, forKey: "myContents")
        newRecord.setValue(score, forKey: "score")
        newRecord.setValue(false, forKey: "complete")
        newRecord.setValue(false, forKey: "reChallenge")
        newRecord.setValue("", forKey: "memo")
        
        do {
            //レコード（行）の即時保存
            try viewContext.save()
        } catch {
        }
    
        //tabbarの2番目のタブに切り替える
        self.tabBarController?.selectedIndex = 1
        //tabbarが無い場合はunwindsegueで戻る
    }
    
        //タイトル（textField)が編集された際に呼ばれる
        func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string1: String) -> Bool {
        
        // 文字数最大を決める.
        let maxLength1: Int = 11
        
        // 入力済みの文字と入力された文字を合わせて取得.
        let str1 = textField.text! + string1
        
        // 文字数がmaxLength以下ならtrueを返し、超えていればアラートを表示させる
        if str1.characters.count < maxLength1 {
            return true
        } else {
            print("10文字を超えています")
            
            //アラートを作る
            let alertController = UIAlertController(title: "文字数エラー", message: "10文字を超えています", preferredStyle: .alert)
            
            //OKボタンを追加 handler...ボタンが押された時発動する処理を記述
            alertController.addAction(UIAlertAction(title: "OK", style: .default, handler: {action in print("OK")}))
            
            //アラートを表示する
            present(alertController,animated: true, completion: nil)
            
            return false
        }
            
    }

    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {

        // 文字数最大を決める.
        let maxLength2: Int = 101
        // textViewの文字数と最大文字数との比較
        if textView.text.characters.count < maxLength2 {
            return true
            
            } else {
                print("100文字を超えています")
                //アラートを作る
                let alertController = UIAlertController(title: "文字数エラー", message: "100文字を超えています", preferredStyle: .alert)
                
                //OKボタンを追加 handler...ボタンが押された時発動する処理を記述
                alertController.addAction(UIAlertAction(title: "OK", style: .default, handler: {action in print("OK")}))
                
                //アラートを表示する
                present(alertController,animated: true, completion: nil)            
                return false
            }
            
        }
    
    //キーボードを閉じる（右上に完了文字）
    func closeKeyBoard(sender:UIButton){
        myContents.resignFirstResponder()
    }

    // 「チャレンジ加算」の登録データを次の画面に推移 ??
    @IBAction func changeSwitch(_ sender: UISwitch) {
        print(sender.isOn)
        
        if sender.isOn {
            print("スイッチON")
            score = 2
        }else{
            print("スイッチOFF")
            score = 1
        }

    }
    

    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    
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
