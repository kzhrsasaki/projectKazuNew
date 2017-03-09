//
//  detailViewController.swift
//  projectKazu
//
//  Created by Apple on 2017/02/22.
//  Copyright © 2017年 Sasaki Kazuhiro. All rights reserved.
//

import UIKit
import CoreData

class detailViewController: UIViewController, UITextViewDelegate {

    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var myContents: UITextView!    
    @IBOutlet weak var myMemo: UITextView!
    @IBOutlet weak var formView: UIView!
    
    //配列を前の画面から引き継ぐ
    var todoList:[NSDictionary] = []
    
    //リストから選ばれた名前（日付）
    var scSelectedDate = ""
    
    //選択されたinputDateが格納される変数その2
    var selectedDate:String = String(describing: Date())

    override func viewDidLoad() {
        super.viewDidLoad()
        //thirdViewControllerからデータを受け取っているかどうかの確認
        print("前の画面から受け取った\(scSelectedDate)")
        //登録日の表示
        dateLabel.text = scSelectedDate
        
        // AppDelegeteにアクセスするための準備、dicはグローバル変数化
        let appDelegate: AppDelegate = UIApplication.shared.delegate as! AppDelegate
 
        var dic:NSDictionary = appDelegate.dic
        myContents.text = dic["myContents"] as! String
        myMemo.text = dic["memo"] as! String
        

        //キーボードの上に「閉じる」ボタンを配置
        //ビューを作成する。
        let upView = UIView()
        upView.frame.size.height = 50
        upView.backgroundColor = UIColor.lightGray
        
        //「閉じる」ボタンを作成する。
        let closeButton = UIButton(frame:CGRect(x:self.view.bounds.size.width-70, y:0, width:70, height:40))
        closeButton.setTitle("閉じる", for: .normal)

        //「閉じる」ボタンを押すとキーボードが閉じてビューが元に戻る
        closeButton.addTarget(self, action: #selector(closeKeyBoard(sender:)), for: .touchUpInside)
        
        //ビューに「閉じるボタン」を追加する。
        upView.addSubview(closeButton)
        
        //キーボードのアクセサリにビューを設定する。
        myMemo.inputAccessoryView = upView
    }

    // myMemo（ふり返り）をcompleteがtrue以降にのみ入力可にする（保留）
    
    // myMemo(ふり返り）を100文字以内の入力とする
    func textViewShouldBeginEditing(_ textView: UITextView) -> Bool {
          print("textViewShouldBeginEditing\n")
          print(textView.tag)
        
        //キーボードが出てたら閉じる
        myMemo.resignFirstResponder()
        
        //withDuration:アニメーションが行われる間隔（秒）
        //animations:変化後の状態
        //completion:アニメーション後に行われる処理
        UIView.animate(withDuration: 0.5, animations: { () -> Void in
            
            self.formView.frame.origin = CGPoint(x: 5, y:self.formView.frame.origin.y - 250)
            
        }, completion: {finished in print("上に現れました")})

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
        
        return true
    }
    
     //baseViewを隠す
    func hideBaseView(){
        self.formView.frame.origin = CGPoint(x: 0, y:self.view.frame.size.height)
    }
    
    //キーボードを閉じる（右上に「閉じる」文字）
    func closeKeyBoard(sender:UIButton){
        myMemo.resignFirstResponder()
        self.formView.frame.origin = CGPoint(x: 5, y:self.formView.frame.origin.y + 250)

    }

    
    // 保存ボタンを押したらcoreDateにmyMemoのデータを新規登録し、かつthirdViewControllerに戻る。
    // dicをグローバル変数扱いにする（appDelegate.dic)
    
    @IBAction func saveMemo(_ sender: UIButton) {
        
        if (myMemo.text != "") {
    
           let appDelegate: AppDelegate = UIApplication.shared.delegate as! AppDelegate
           let viewContext = appDelegate.persistentContainer.viewContext
           var dic:NSDictionary = appDelegate.dic
           let date = Date()
           let df = DateFormatter()
           df.dateFormat = "yy/MM/dd"
           //データの更新
           let request: NSFetchRequest<ToDo> = ToDo.fetchRequest()
    
           do{
               //dic["inputDate"]をそのまま使う
               let namePredicte = NSPredicate(format: "inputDate = %@", dic["inputDate"] as! CVarArg)
               request.predicate = namePredicte
               let fetchResults = try! viewContext.fetch(request)
    
               //登録された日付を元にmyMemoに1件取得　新しい値を入れる
               for result: AnyObject in fetchResults {
                   let record = result as! NSManagedObject
                   record.setValue(myMemo.text, forKey: "memo")
              }
                 try viewContext.save()
              } catch {
              }
               //appDelegate.dic["memo"] = myMemo.text
            
            let alertController = UIAlertController(title: "入力確認", message: "入力内容を保存しますか？", preferredStyle: .alert)
            
            //OKボタンを追加 handler...ボタンが押された時発動する処理を記述
            alertController.addAction(UIAlertAction(title: "OK", style: .default, handler: {action in self.dismiss(animated: false, completion: nil)}))
            
            //アラートを表示する
            present(alertController,animated: false, completion: nil)
            
         } else {
            //エラーを返す
            print("入力されていません")
            //アラートを作る
            let alertController = UIAlertController(title: "未入力エラー", message: "文字が入力されていません", preferredStyle: .alert)
            
            //OKボタンを追加 handler...ボタンが押された時発動する処理を記述
            alertController.addAction(UIAlertAction(title: "OK", style: .default, handler: {action in self.formView.frame.origin = CGPoint(x: 5, y:self.formView.frame.origin.y + 250)}))
            
            //アラートを表示する
            present(alertController,animated: false, completion: nil)
         }
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
