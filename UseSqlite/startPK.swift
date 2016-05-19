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
    var Flag:Bool=true;
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
        db.execute("update t_matchFlag set redAll='\(Matchnow.text!)' where uid in(select uid from t_matchFlag order by uid desc)");
    }
    func instoFlag()
    {
        let sql = "insert into t_matchFlag(redAll,redNow,blueAll,blueNow) values('\(redAllMatch.text!)','\(redNowMatch.text!)','\(blueAllMatch.text!)','\(blueNowMatch.text!)')"
        //let sql2 =""
        //通过封装的方法执行sql
        db.execute(sql)
        db.execute("update Match_tab set matchCount='\(Matchnow.text!)' where uid in(select uid from Match_tab order by uid desc)")
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
        if(Flag)
        {
            if(Int(redNowMatch.text!)!+1>=11&&(Int(redNowMatch.text!)!+1)-(Int(blueNowMatch.text!))!>=2)
            {
                if(Int(redAllMatch.text!)!+1>=(Int(Matchall.text!)!+1)/2)
                {
                    redAllMatch.text=String(1+Int(redAllMatch.text!)!);
                    redNowMatch.text="0";
                    matchStyle.text="红队胜利！";
                    Flag=false;
                }
                else
                {
                    Matchnow.text=String(1+Int(Matchnow.text!)!);
                    blueAllMatch.text=String(1+Int(blueAllMatch.text!)!);
                    redNowMatch.text="0";
                    blueNowMatch.text="0";
                    matchStyle.text="当局完成!";
                }
            }
            else
            {
                redNowMatch.text=String(1+Int(redNowMatch.text!)!)
                matchStyle.text="正在比赛......";
            }
        }
        
        
    }
    @IBAction func redJian(sender: UIButton) {
        if(Int(redNowMatch.text!)!-1>=0)
        {
            redNowMatch.text=String(Int(redNowMatch.text!)!-1)
        }

    }
    @IBAction func blueAdd(sender: UIButton) {
        if(Flag)
        {
            if(Int(blueNowMatch.text!)!+1>=11&&(Int(blueNowMatch.text!)!+1)-(Int(redNowMatch.text!))!>=2)
            {
                if(Int(blueAllMatch.text!)!+1>=(Int(Matchall.text!)!+1)/2)
                {
                    blueAllMatch.text=String(1+Int(blueAllMatch.text!)!);
                    blueNowMatch.text="0";
                    matchStyle.text="蓝队胜利！";
                    Flag=false;
                }
                else
                {
                    Matchnow.text=String(1+Int(Matchnow.text!)!);
                    blueAllMatch.text=String(1+Int(blueAllMatch.text!)!);
                    redNowMatch.text="0";
                    blueNowMatch.text="0";
                    matchStyle.text="当局完成!";
                }
                
            }
            else
            {
                blueNowMatch.text=String(1+Int(blueNowMatch.text!)!)
                matchStyle.text="正在比赛......";
            }

        }
    }
    @IBAction func blueJian(sender: UIButton) {
        if((Int(blueNowMatch.text!)!-1)>=0)
        {
            blueNowMatch.text=String(Int(blueNowMatch.text!)!-1)
        }
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    @IBAction func MatchClear(sender: UIButton) {
        redAllMatch.text="0"
        redNowMatch.text="0"
        blueAllMatch.text="0"
        blueNowMatch.text="0"
        //matchStyle.text="0"
        Matchnow.text="1";
    }
    @IBAction func ExitApp(sender: UIButton) {
        
    }
    @IBAction func SaveAndReturn(sender: UIButton) {
        //UpdataLastFlag();
        instoFlag();
        //当前局数未加一
    }
}
