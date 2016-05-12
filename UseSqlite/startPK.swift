//
//  startPK.swift
//  UseSqlite
//
//  Created by MasterBoot on 16/5/9.
//  Copyright © 2016年 MasterBoot. All rights reserved.
//

import UIKit

class startPK: UIViewController {
    var db:SQLiteDB!
    @IBOutlet weak var Matchall: UILabel!
    @IBOutlet weak var Matchnow: UILabel!
    @IBOutlet weak var redAllMatch: UILabel!
    @IBOutlet weak var redNowMatch: UILabel!
    @IBOutlet weak var blueAllMatch: UILabel!
    @IBOutlet weak var blueNowMatch: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()

        db = SQLiteDB.sharedInstance()
        //如果表还不存在则创建表（其中uid为自增主键）
        db.execute("create table if not exists t_user(uid integer primary key,uname varchar(20),mobile varchar(20))")
        initUser();
    }
    func initUser() {
        let data = db.query("select * from format_tab")
        if data.count > 0 {
            //获取最后一行数据显示
            let user = data[data.count - 1]
            Matchall.text = user["PKcount"] as? String
    
        }
    }
    
    @IBAction func redAdd(sender: UIButton) {
        //redNowMatch.text=((redNowMatch.text as? Int)++)as?String;
    }
    @IBAction func redJian(sender: UIButton) {
    }
    @IBAction func blueAdd(sender: UIButton) {
    }
    @IBAction func blueJian(sender: UIButton) {
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
