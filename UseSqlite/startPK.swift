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
    override func viewDidLoad() {
        super.viewDidLoad()

        db = SQLiteDB.sharedInstance()
        //如果表还不存在则创建表（其中uid为自增主键）
        db.execute("create table if not exists t_user(uid integer primary key,uname varchar(20),mobile varchar(20))")
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
