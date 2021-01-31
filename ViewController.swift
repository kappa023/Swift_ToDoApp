//
//  ViewController.swift
//  ToDoApp
//
//  Created by kappa on 2021/01/30.
//

import UIKit

class ViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {


    @IBOutlet weak var tableView: UITableView!
    
    var todolist = [String]()
    // インスタンスの生成
    let userDefaults = UserDefaults.standard
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        if let storedTodoList = userDefaults.array(forKey: "todolist") as? [String] {
                todolist.append(contentsOf: storedTodoList)
            }
    }
    
    
    
    @IBAction func addBtn(_ sender: Any) {
        
        let alert = UIAlertController(title: "ToDo追加", message: "入力してください", preferredStyle: UIAlertController.Style.alert)
        alert.addTextField(configurationHandler:nil)
        let okAction = UIAlertAction(title: "OK", style: UIAlertAction.Style.default){(acrion:UIAlertAction)in
            //okを押した時
            if let textField = alert.textFields?.first{
                
                self.todolist.insert(textField.text!, at: 0)
                self.tableView.insertRows(at: [IndexPath(row: 0, section: 0)], with: UITableView.RowAnimation.right)
                self.userDefaults.set(self.todolist,forKey: "todolist")
                
            }
            
            
            
        }
        
        alert.addAction(okAction)
        let cancel = UIAlertAction(title: "CANCELL", style: UIAlertAction.Style.cancel, handler: nil)
        alert.addAction(cancel)
        present(alert, animated: true, completion: nil)
        
    }
    
    //セルの数指定
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return todolist.count
    }
    
    //セルの中身設定
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell",for: indexPath)
        let todoTile = todolist[indexPath.row]
        cell.textLabel?.text = todoTile
        return cell
        
    }
    //セルのデリート機能
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == UITableViewCell.EditingStyle.delete{
            todolist.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath as IndexPath], with: UITableView.RowAnimation.automatic)
            userDefaults.set(todolist,forKey: "todolist")
        }
    }
    
    

}

