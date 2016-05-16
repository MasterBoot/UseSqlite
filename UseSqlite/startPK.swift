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
    @IBOutlet weak var redName: UILabel!
    @IBOutlet weak var blueName: UILabel!
    @IBOutlet weak var redAllMatch: UILabel!
    @IBOutlet weak var redNowMatch: UILabel!
    @IBOutlet weak var blueAllMatch: UILabel!
    @IBOutlet weak var blueNowMatch: UILabel!
    @IBOutlet weak var matchStyle: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        db = SQLiteDB.sharedInstance()
        //如果表还不存在则创建表（其中uid为自增主键）
        db.execute("create table if not exists t_matchFlag(uid integer primary key,redAll varchar(20),redNow varchar(20),blueAll varchar(20),blueNow varchar(20))")
        initUser();
        print("daewqwe")
    }
    func UpdataLastFlag()
    {
        db.execute("update t_matchFlag set redAll='\(redAllMatch.text!)',redNow='\(redNowMatch.text!)',blueAll='\(blueAllMatch.text!)',blueNow='\(blueNowMatch.text!)' where uid in(select uid from t_matchFlag order by uid desc)");
    }
    func instoFlag()
    {
        let sql = "insert into t_matchFlag(redAll,redNow,blueAll,blueNow) values('\(redAllMatch.text!)','\(redNowMatch.text!)','\(blueAllMatch.text!)','\(blueNowMatch.text!)')"
        //print("sql: \(sql)")
        //通过封装的方法执行sql
        db.execute(sql)
    }
    func initUser() {
        let data = db.query("select * from Match_tab")
        if data.count > 0 {
            let user = data[data.count - 1]
            Matchall.text = user["PKcount"] as? String
            redName.text = user["Redtiem"] as? String
            blueName.text = user["Bluetime"] as? String
            Matchnow.text=user["matchCount"] as? String
        }
        let matchData = db.query("select * from t_matchFlag")
        if matchData.count > 0 {
            let match = matchData[matchData.count - 1]
            redAllMatch.text = match["redAll"] as? String
            redNowMatch.text = match["redNow"] as? String
            blueAllMatch.text = match["blueAll"] as? String
            blueNowMatch.text=match["blueNow"] as? String
        }

    }
    @IBAction func redAdd(sender: UIButton) {
        if(Int(redNowMatch.text!)!+1>=11&&(Int(redNowMatch.text!)!+1)-(Int(blueNowMatch.text!))!>=2)
        {
            Matchnow.text=String(1+Int(Matchnow.text!)!)
            redNowMatch.text="0";
            blueNowMatch.text="0";
            redAllMatch.text=String(1+Int(redAllMatch.text!)!)
            matchStyle.text="当局完成!";
        }
        redNowMatch.text=String(1+Int(redNowMatch.text!)!)
    }
    @IBAction func redJian(sender: UIButton) {
        redNowMatch.text=String(Int(redNowMatch.text!)!-1)
    }
    @IBAction func blueAdd(sender: UIButton) {
        blueNowMatch.text=String(1+Int(blueNowMatch.text!)!)
    }
    @IBAction func blueJian(sender: UIButton) {
        blueNowMatch.text=String(Int(blueNowMatch.text!)!-1)
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    @IBAction func SaveAndReturn(sender: UIButton) {
        //UpdataLastFlag();
        instoFlag();
        //当前局数未加一
    }
}
