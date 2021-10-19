//
//  ViewController.swift
//  ToDo App
//
//  Created by Julien on 07/10/21.
//

import UIKit


class ViewController: UIViewController,OnButtonTapAddTaskWindow {
 
    @IBOutlet var TodoTableView: UITableView!
    let userDefaults = UserDefaults.standard
    var todoLists=[Task]()
    var completedLists=[Task]()
    var delegate:AlarmSettingProtocol?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        todoLists=fetchTodoListFromUserDefault() ?? [Task]()
        completedLists=fetchCompletedListFromUserDefault() ?? [Task]()
        TodoTableView.delegate=self
        TodoTableView.dataSource=self
        // Do any additional setup after loading the view.
        TodoTableView.register(UINib(nibName: "TodoTableViewCell", bundle: nil), forCellReuseIdentifier: TodoTableViewCell.cellIdentifier)
    }
    override func viewDidAppear(_ animated: Bool) {
        self.navigationController?.navigationBar.topItem?.title = "TODO"
           let lbNavTitle = UILabel (frame: CGRect(x: 0, y: 0, width: 320, height: 40))
           lbNavTitle.textColor = UIColor.white
           lbNavTitle.center = CGPoint(x: 0, y: 0)
           lbNavTitle.textAlignment = .left
           lbNavTitle.text = "TODO"
           self.navigationItem.titleView = lbNavTitle
    }
    @IBAction func didTapAddButton(_ sender: UIButton) {
        let storyboard = UIStoryboard(name: "AddTaskWindow", bundle: nil)
        let vc=storyboard.instantiateViewController(identifier: "addTask") as! AddTaskWindow
        vc.delegate=self
        navigationController?.present(vc, animated: true, completion: nil)
    }

    func onbuttonTapOnAddingTask(task: Task,isAlarmSet:Bool) {
        todoLists = fetchTodoListFromUserDefault() ?? [Task]()
        self.todoLists.append(task)
        saveTodoListtoUserDefault(taskArray: todoLists)
        print(fetchTodoListFromUserDefault() ?? [Task]())
        
        self.TodoTableView.reloadData()
    }
    func onbuttonTapOnEditingTask(task: Task,index: IndexPath) {
        todoLists = fetchTodoListFromUserDefault() ?? [Task]()
        self.todoLists[index.row]=task
        saveTodoListtoUserDefault(taskArray: todoLists)
        self.TodoTableView.reloadData()
        
    }
    func saveTodoListtoUserDefault(taskArray:[Task]){
        do {
            let encoder = JSONEncoder()
            let data = try encoder.encode(taskArray)
            self.userDefaults.set(data, forKey: "todoList")
        } catch {
            print("Unable to Encode CrossPromoPopUpDict (\(error))")
        }
    }
    func fetchTodoListFromUserDefault() -> [Task]? {
            if let data = UserDefaults.standard.data(forKey: "todoList") {
                do {
                    let decoder = JSONDecoder()
                    let arr = try decoder.decode([Task].self, from: data)
                    return arr
                } catch {
                    print("Unable to Decode Notes (\(error))")
                    return nil
                }
            } else {
                return nil
            }
        }
}

extension ViewController:UITableViewDelegate,UITableViewDataSource{
    func numberOfSections(in tableView: UITableView) -> Int {
        2
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if(section==0){
            return todoLists.count
        }
        else{
            return completedLists.count
        }
                
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell=tableView.dequeueReusableCell(withIdentifier: TodoTableViewCell.cellIdentifier,for: indexPath) as! TodoTableViewCell
        cell.indexPath=indexPath
        cell.delegate=self
        if(indexPath.section==0){
            cell.taskCellView.backgroundColor=UIColor.white
            cell.taskName.text=todoLists[indexPath.row].taskName
            cell.taskDescription.text=todoLists[indexPath.row].taskDescription
            cell.RadioButton.isSelected=false
            cell.EditButton.isHidden=false
            cell.alarmButton.isHidden = !todoLists[indexPath.row].isAlarmSet
        }
        else{
            cell.taskCellView.backgroundColor=UIColor(red: 0.96, green: 0.97, blue: 1.00, alpha: 1.00)
            cell.taskName.text=completedLists[indexPath.row].taskName
            cell.taskDescription.text=completedLists[indexPath.row].taskDescription
            cell.RadioButton.isSelected=true
            cell.EditButton.isHidden=true
            cell.alarmButton.isHidden = !completedLists[indexPath.row].isAlarmSet
            
        }
        return cell
    }
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        if(section==0){
            return "TO DO LIST"
        }
        else{
            return "COMPLETED"
        }
    }
    
    
}
extension ViewController:TaskAddorEditDelegate{
    
    func didTapEditTask(at index: IndexPath) {
        UNUserNotificationCenter.current().removePendingNotificationRequests(withIdentifiers: [self.todoLists[index.row].taskName])
        let storyboard = UIStoryboard(name: "AddTaskWindow", bundle: nil)
        let vc=storyboard.instantiateViewController(identifier: "addTask") as! AddTaskWindow
        vc.delegate=self
        
        vc.taskNameForEdit=todoLists[index.row].taskName
        vc.taskDescriptionForEdit=todoLists[index.row].taskDescription
        vc.taskDateTimeForEditing=todoLists[index.row].alarmDateTime
        vc.isfromediting=true
        vc.indexPath=index
        navigationController?.present(vc, animated: true, completion: nil)
        
    
    }
    func didTapRadioButton(at index: IndexPath) {
        UNUserNotificationCenter.current().removePendingNotificationRequests(withIdentifiers: [self.todoLists[index.row].taskName])
        completedLists=fetchCompletedListFromUserDefault() ?? [Task]()
        todoLists=fetchTodoListFromUserDefault() ?? [Task]()
        
        self.completedLists.append(self.todoLists[index.row])
        saveCompletedListtoUserDefault(taskArray: completedLists)
        
        self.todoLists.remove(at: index.row)
        saveTodoListtoUserDefault(taskArray: todoLists)
        self.TodoTableView.reloadData()
    }
    func saveCompletedListtoUserDefault(taskArray:[Task]){
        do {
            let encoder = JSONEncoder()
            let data = try encoder.encode(taskArray)
            self.userDefaults.set(data, forKey: "completedList")
        } catch {
            print("Unable to Encode CrossPromoPopUpDict (\(error))")
        }
    }
    func fetchCompletedListFromUserDefault() -> [Task]? {
            if let data = UserDefaults.standard.data(forKey: "completedList") {
                do {
                    let decoder = JSONDecoder()
                    let arr = try decoder.decode([Task].self, from: data)
                    return arr
                } catch {
                    print("Unable to Decode Notes (\(error))")
                    return nil
                }
            } else {
                return nil
            }
        }

    
    func didTapDeleteTask(at index: IndexPath) {
        let storyboard = UIStoryboard(name: "DeleteTask", bundle: nil)
        let vc=storyboard.instantiateViewController(identifier: "deleteTask") as! DeleteTaskViewController
        vc.delegate=self
        vc.index=index
        navigationController?.present(vc, animated: true, completion: nil)
    }
        
    
    
}
extension ViewController:onDeleteConfirmedProtocol{
    func onDeleteConfirmedButtonClicked(index: IndexPath) {
        UNUserNotificationCenter.current().removePendingNotificationRequests(withIdentifiers: [self.todoLists[index.row].taskName])
        
        completedLists=fetchCompletedListFromUserDefault() ?? [Task]()
        todoLists=fetchTodoListFromUserDefault() ?? [Task]()
        
        if(index.section==0){
            self.todoLists.remove(at: index.row)
            saveTodoListtoUserDefault(taskArray: todoLists)
            self.TodoTableView.reloadData()
        }
        else{
            self.completedLists.remove(at: index.row)
            saveCompletedListtoUserDefault(taskArray: completedLists)
            self.TodoTableView.reloadData()
        }
    }
    
    
}
