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
    
    @IBOutlet weak var periodTableView: UITableView!
    
    // Tableで使用する配列を定義する
    let myWeeks:NSArray = ["今週","1週前","2週前","3週前",]
    let myMonths:NSArray = ["今月","1ヶ月前","2ヶ月前","3ヶ月前","4ヶ月前","5ヶ月前",]
    
    // Sectionで使用する配列を定義する
    let mySections:NSArray = ["週別成績（4週)","月別成績(6か月）"]
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    //セクションの数を返す
    func numberOfSections(in tableView: UITableView) -> Int {
        return mySections.count
    }
    //セクションのタイトルを返す
        func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
            return mySections[section] as? String
    }
    //セルが選択された際に呼び出される
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
