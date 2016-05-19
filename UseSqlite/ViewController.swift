import UIKit

class ViewController: UIViewController {
    
    var db:SQLiteDB!
    
    @IBOutlet var txtUname: UITextField!
    @IBOutlet var txtMobile: UITextField!
    
    @IBOutlet weak var matchCount: UITextField!//比赛总局数
    @IBOutlet weak var redT: UITextField!//红队
    @IBOutlet weak var BlueT: UITextField!//蓝队
    override func viewDidLoad() {
        super.viewDidLoad()
        //ReadMatch()
        //获取数据库实例
        db = SQLiteDB.sharedInstance()
        //如果表还不存在则创建表（其中uid为自增主键）
        db.execute("create table if not exists Match_tab(uid integer primary key,PKcount varchar(20),Redtiem varchar(20),Bluetime varchar(20),matchCount varchar(10))")
        //如果有数据则加载
        //initUser()
        ViewFormartSet();
    }
    func ViewFormartSet()
    {
        
        let data = db.query("select * from Match_tab")
            if data.count > 0 {
                //获取最后一行数据显示
                let user = data[data.count - 1]
                matchCount.text=user["PKcount"] as? String
                redT.text = user["Redtiem"] as? String
                BlueT.text = user["Bluetime"] as? String
        }
    }
    //创建比赛
    @IBAction func newMatch(sender: UIButton) {
        let Count = matchCount.text!;
        let red = redT.text!;
        let Blue=BlueT.text!;
        //插入数据库，这里用到了esc字符编码函数，其实是调用bridge.m实现的
        let sql = "insert into Match_tab(PKcount,Redtiem,Bluetime,matchCount) values('\(Count)','\(red)','\(Blue)','1')"
        //print("sql: \(sql)")
        //通过封装的方法执行sql
        db.execute(sql)
    }
    
    @IBAction func saveClicked(sender: AnyObject) {
        saveUser()
    }
    func ReadMatch(){
        let Count = matchCount.text!;
        let red = redT.text;
        let Blue=BlueT.text!;
        //插入数据库，这里用到了esc字符编码函数，其实是调用bridge.m实现的
        let sql = "insert into Match_tab(PKcount,Redtiem,Bluetime) values('\(Count)','\(red)','\(Blue)')"
        //print("sql: \(sql)")
        //通过封装的方法执行sql
        db.execute(sql)
    }
    @IBAction func readData(sender: AnyObject) {
        initUser()
    }
    //从SQLite加载数据
    func initUser() {
        let data = db.query("select * from format_tab")
        if data.count > 0 {
            //获取最后一行数据显示
            let user = data[data.count - 1]
            txtUname.text = user["uname"] as? String
            txtMobile.text = user["mobile"] as? String
        }
    }
    //保存数据到SQLite
    func saveUser() {
        let uname = self.txtUname.text!
        let mobile = self.txtMobile.text!
        //插入数据库，这里用到了esc字符编码函数，其实是调用bridge.m实现的
        let sql = "insert into format_tab(uname,mobile) values('\(uname)','\(mobile)')"
        //print("sql: \(sql)")
        //通过封装的方法执行sql
        db.execute(sql)
        //print(result)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}