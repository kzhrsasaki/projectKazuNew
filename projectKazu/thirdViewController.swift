//
//  thirdViewController.swift
//  projectKazu
//
//  Created by Apple on 2017/02/15.
//  Copyright © 2017年 Sasaki Kazuhiro. All rights reserved.
//

import UIKit
import CoreData

class thirdViewController: UIViewController,UITableViewDataSource, UITableViewDelegate{
    
    // tableViewの定義
    @IBOutlet weak var myTableView: UITableView!
  
    //辞書配列の定義（文字列で良いか？）
    //var todoList:[String] = NSArray() as! [String]
    var todoList:[NSDictionary] = []
    
    //選択されたinputDateが格納される変数
    var selectedDate:String = String(describing: Date())
    
    //選択されたmyTitle、myContentsが格納される変数
    var selectedTitle:String = ""
    var selectedContents:String = ""
    
    
    //過去履歴表示変更設定の各項目
    @IBOutlet weak var fromDate: UITextField!
    @IBOutlet weak var toDate: UITextField!
    
    //datePickerを載せるView
    let baseView:UIView = UIView(frame: CGRect(x: 0, y: 720, width: 200, height: 250))
    //datePickerを生成(日付編集時）
    let myDatePicker:UIDatePicker = UIDatePicker(frame: CGRect(x: 10, y: 20, width: 300, height: 220))
    //datePickerを隠すためのボタン
    let closeBtnDatePicker:UIButton = UIButton(type: .system)
    
    //詳細画面とのセグエ連携のためのカウント用変数（初期値0)
    var detailCount = 0
    
    // 詳細画面から戻ってくる(unwind segue)
    @IBAction func back(Segue:UIStoryboardSegue){
    print("戻る")
    }
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // 編集ボタンを左上に配置して履歴の削除機能
        navigationItem.leftBarButtonItem = editButtonItem
    
        //日付が変わった時のイベントをdatePickerに設定
        myDatePicker.addTarget(self, action: #selector(showDateSelected(sender:)), for: .valueChanged)
        
        //baseViewにdatePickerを配置
        baseView.addSubview(myDatePicker)
        
        //baseViewにボタンを配置
        //位置、大きさを決定
        closeBtnDatePicker.frame = CGRect(x: self.view.frame.width - 60, y: 0, width: 50, height: 20)
        
        //タイトルの設定
        closeBtnDatePicker.setTitle("閉じる", for: .normal)
        
        //イベントの追加
        closeBtnDatePicker.addTarget(self, action: #selector(closeDatePickerView(sender:)), for: .touchUpInside)
        
        //Viewに追加
        baseView.addSubview(closeBtnDatePicker)
        
        //下にぴったり配置（下から出したいので）、横幅ピッタリの大きさにしておく
        baseView.frame.origin = CGPoint(x: 0, y: self.view.frame.size.height)
        //横幅
        baseView.frame.size = CGSize(width: self.view.frame.width, height: baseView.frame.height)
        //背景色をGrayにセット
        baseView.backgroundColor = UIColor.gray
        //画面に追加
        self.view.addSubview(baseView)
        
        
        //Coredataからのdataを読み込む処理（後で関数を定義）
        read()
        
//        //ディクショナリー型に代入
//        //AppDelegateへのアクセス準備
//       let myApp = UIApplication.shared.delegate as! AppDelegate
//       myApp.dic = NSDictionary()
        
        
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
    
        //いったん配列を空っぽにする（初期化する）
       // todoList = NSArray.self as! [String]

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
            todoList.append(["inputDate":inputDate,"dueDate":dueDate,"myTitle":myTitle,"score":score,"complete":complete,"reChallenge":reChallenge,"myContents":myContents,"memo":memo])
            }
        } catch {
        }
        //TableViewの再描画、書く場所が大事
        myTableView.reloadData()
        
        // データの並べ替え（inputDateの降順）
        let sortDescription = NSSortDescriptor(key: "inputDate", ascending: false)
        let sortDescAry = [sortDescription]
        todoList = ((todoList as NSArray).sortedArray(using: sortDescAry) as NSArray) as! [NSDictionary]
        
    }
    
    //TableViewの処理
    //行数を指定
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return todoList.count
    }
    
    //セルの表示
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! TableViewCell
        
        //セルを表示するためのコード"\()"
        print(todoList[indexPath.row])
        
        var dic:NSDictionary = todoList[indexPath.row]
        
        let df = DateFormatter()
        df.dateFormat = "yy/MM/dd"
        
        //日付を文字列に変換して登録日と期限日を表示
        cell.inputDateLabel.text = df.string(from: dic["inputDate"] as! Date)
        cell.dueDateLabel.text = df.string(from: dic["dueDate"] as! Date)
        // myTitleの表示
        cell.myTitleLabel.text = dic["myTitle"] as! String
        
        var completeFlag = dic["complete"] as! Bool
        //スコア表示の定義
        var score:Int = 0
        if (completeFlag == true){
             score = dic["score"] as! Int

        //TODO:不明点
//        } else if (Date() <= dic["dueDate"] as! Date) {
//             score = nil
            
        } else {
             score = 0
        }
        
         cell.scoreLabel.text = "\(score)点"
        
        // reChallengeボタン表示の定義
        var reChallengBtnTitle:String = ""
        if ((score == 0) && (NSDate() as Date > dic["dueDate"] as! Date)) {
             reChallengBtnTitle = "再挑戦"
        } else {
            reChallengBtnTitle = ""
        }
        
        cell.reChallengeButton.setTitle(reChallengBtnTitle, for: .normal)
        
        //completeボタン表示の定義
        var completeBtnTitle:String = "完了入力"
        if (completeFlag == true){
             completeBtnTitle = "達成!"
        } else if (Date() > dic["dueDate"] as! Date){
            completeBtnTitle = ""
        } else {
             completeBtnTitle = "完了入力"
        }
        cell.completeButton.setTitle(completeBtnTitle, for: .normal)
        //追加分
        cell.completeButton.tag = indexPath.row
        cell.detailButton.tag = indexPath.row
        cell.reChallengeButton.tag = indexPath.row
        
        return cell
    }
    
    //CompleteBtnを押したとき、CoreDateから該当のinputDateをキーとするデータを取り出して、complete = true に書き換える
    @IBAction func tapCompleteBtn(_ sender: UIButton) {
        
        let appDelegate: AppDelegate = UIApplication.shared.delegate as! AppDelegate
        let viewContext = appDelegate.persistentContainer.viewContext
        var dic:NSDictionary = todoList[sender.tag]
        let date = Date()
        let df = DateFormatter()
        df.dateFormat = "yy/MM/dd"
           //データの更新
            let request: NSFetchRequest<ToDo> = ToDo.fetchRequest()
            var strSavedDate:String = df.string(from: dic["inputDate"] as! Date)
            var savedDate:Date = df.date(from: strSavedDate)!
        
            do{
              let namePredicte = NSPredicate(format: "inputDate = %@", savedDate as CVarArg)
                request.predicate = namePredicte
                let fetchResults = try! viewContext.fetch(request)
                
                //登録された日付を元に1件ずつ取得　"complete"をtrueの値を入れる
                for result: AnyObject in fetchResults {
                    let record = result as! NSManagedObject
                    record.setValue(true, forKey: "complete")
                }
                try viewContext.save()
            } catch {
            }
          //complete=trueとなった後にボタンを押せなくする
        sender.isEnabled = false
    }
    
    //Editボタンが押された（データ削除）
    override func setEditing(_ editing: Bool, animated: Bool) {
        super.setEditing(editing, animated: animated)
        myTableView.isEditing = editing
    }
    //削除可能なセルのindexPathを指定
    func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
//      //score == 0 の場合のみ削除可能にしたい（保留）
//        let appDelegate: AppDelegate = UIApplication.shared.delegate as! AppDelegate
//        let dic:NSDictionary = appDelegate.dic
//        
//        
//        if (dic["score"] as! Int == 0){
           return true
//        } else {
//           return false
//        }
    }
    
    //deleteボタン表示を「非表示」に変更
    func tableView(tableView: UITableView, titleForDeleteConfirmationButtonForRowAtIndexPath indexPath: NSIndexPath) -> String? {
        return "削除"
    }
    
    //実際に削除された時の処理を実装する
    func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        
        if editingStyle == UITableViewCellEditingStyle.delete {
            print("削除")
        // 先にデータを更新する
        todoList.remove(at: indexPath.row)
        
//        // それからテーブルの更新
//        myTableView.deleteRowsAtIndexPaths([NSIndexPath(forRow: indexPath.row, inSection: 0)],
//            withRowAnimation: UITableViewRowAnimation.Fade)
        
        myTableView.reloadData()
        }
      
    }
    // 通常モードではスワイプ削除できないようにする
    func tableView(tableView: UITableView, editingStyleForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCellEditingStyle {
        if tableView.isEditing {
            return UITableViewCellEditingStyle.delete
        } else {
            return UITableViewCellEditingStyle.none
        }
    }
    
    //過去履歴表示設定変更
    //textFieldにカーソルが当たったとき（開始日、終了日）
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        print("textFieldShouldBeginEditing 発動された")
            print(textField.tag)
        //日付のview（下で関数を書いておけば、１行で済む）
        myDatePicker.tag = textField.tag
        displayDatePickerView()
        
        return false
    }

    //datePickerのViewを表示する
    func displayDatePickerView(){
        UIView.animate(withDuration: 0.5, animations: {() -> Void in
            
            self.baseView.frame.origin = CGPoint(x: 0, y: self.view.frame.size.height -  self.baseView.frame.height)

        },completion:{finished in print("DatePickerが現れました")})
    }
    
    //DatePickerが載ったViewを隠す（先にメソッドをこちらで書いておく）、「datePickerViewの表示」のところをコピーしてy軸を修正）
    func closeDatePickerView(sender:UIButton){
        UIView.animate(withDuration: 0.5, animations: {() -> Void in
            
            self.baseView.frame.origin = CGPoint(x: 0, y: self.view.frame.size.height)
            
        },completion:{finished in print("DatePickerを隠しました")})
    }
    
    //DatePickerで選択している日付を変えた時、日付用のtextFieldに値を表示
    func showDateSelected(sender:UIDatePicker){
        
        //フォーマットを設定
        let df = DateFormatter()
        df.dateFormat = "yyyy/MM/dd"
        
        //日付を文字列に変換（日付用のTextFieldが2つあるため、定数ではなくて変数）
        var strSelectedDate = df.string(from: sender.date)
        
        //TextFieldに値を表示
        switch sender.tag{
        case 1:
            fromDate.text = strSelectedDate
        case 2:
            toDate.text = strSelectedDate
        default: break
        }
    }
    // 設定変更ボタンを押してfromDate とtoDateの条件で検索して並べ替える（降順）機能
    @IBAction func changePeriodSortBtn(_ sender: UIButton) {
  
        //TODO:後で
//        if ((fromDate.text != nil) && (toDate.text != nil) && (Date(from: fromDate.text) < Date(from: toDate.text))) {
//        // coreDataからデータを取得して日付を範囲指定して並べ替える、elseの場合はエラーを返す
//            
//        }
        
    }

    //「詳細」ボタンが押されたときに発動
    @IBAction func touchDetailBtn(_ sender: UIButton) {
    
            //選択された行のinputDateを取り出す
            let appDelegate: AppDelegate = UIApplication.shared.delegate as! AppDelegate
        
            appDelegate.dic = todoList[sender.tag]
            let date = Date()
            let df = DateFormatter()
            df.dateFormat = "yy/MM/dd"
            //データの更新
            // dic[]のグローバル変数化
        
            var strSavedDate:String = df.string(from: appDelegate.dic["inputDate"] as! Date)
            
            selectedDate = strSavedDate
        
            //セグエを使って画面移動、identifierに入力済みのもの
            performSegue(withIdentifier: "showDetailView", sender: nil)
        
    }
    
    //再挑戦ボタンが押された際に、secondViewControllerに戻り、myTitleとmyContentsを元のまま保持した上で、他のデータをクリアして表示する。
    @IBAction func tapReChallengeBtn(_ sender: UIButton) {
        //選択された行の"myTitle"と"myContens"を取り出す
        let appDelegate: AppDelegate = UIApplication.shared.delegate as! AppDelegate
        
        appDelegate.dic = todoList[sender.tag]
        
        selectedTitle = appDelegate.dic["myTitle"] as! String
        selectedContents = appDelegate.dic["myContents"] as! String
        
        //セグエを使って画面移動、identifierに入力済みのもの
        performSegue(withIdentifier: "showSecondView", sender: nil)
        
    }
    //Segueで画面遷移する時発動
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    //「詳細」からdetailViewControllerへ推移
      if (segue.identifier == "showDetailView"){
        //ダウンキャスティングで型変換
        let detailVC = segue.destination as! detailViewController
        
        //次の画面detailViewControllerに選択された日付と配列を渡す
        detailVC.scSelectedDate = selectedDate
        
        detailVC.todoList = todoList
        // デバッグエリアの情報をわかりやすく表示
        print("番号\(detailVC.scSelectedDate)を次の画面へ渡す")
    } else {
    //「再チャレンジ」からsecondVireControllerへ推移
        //ダウンキャスティングで型変換
        let secondVC = segue.destination as! secondViewController
        
        //遷移先画面secondViewControllerに選択されたtitleとcontentsを渡す
        secondVC.scSelectedTitle = selectedTitle
        
        secondVC.scSelectedContents = selectedContents
        // デバッグエリアの情報をわかりやすく表示
        print("番号\(secondVC.scSelectedTitle)を次の画面へ渡す")
        print("番号\(secondVC.scSelectedContents)を次の画面へ渡す")
    
        }
    }
        
  
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */


