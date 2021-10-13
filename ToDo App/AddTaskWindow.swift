//
//  AddTaskWindow.swift
//  ToDo App
//
//  Created by Julien on 11/10/21.
//

import UIKit
import UserNotifications

class AddTaskWindow: UIViewController {

    @IBOutlet var taskName: UITextField!
    @IBOutlet var taskDescription: UITextField!
    @IBOutlet var date: UITextField!
    @IBOutlet var time: UITextField!
    var delegate:OnButtonTapAddTaskWindow?
    var todovm=TodoViewModel()
    var dateInDate:Date!
    var indexPath:IndexPath!

    var isfromediting:Bool=false
    var taskNameForEdit:String?
    var taskDescriptionForEdit:String?
    var taskDateForEditing:String?
    var taskTimeForEditing:String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if(isfromediting){
            taskName.text=taskNameForEdit
            taskDescription.text=taskDescriptionForEdit
            date.text=taskDateForEditing
            time.text=taskTimeForEditing
        }

        // Do any additional setup after loading the view.
    }
 
    @IBAction func didTapCancelButton(_ sender: UIButton) {
        self.presentingViewController?.dismiss(animated: true, completion: nil)
    }
    @IBAction func didTapAddButton(_ sender: UIButton) {
        
        
        if(isfromediting==false){
            self.presentingViewController?.dismiss(animated: true, completion: nil)
            self.delegate?.onbuttonTapOnAddingTask(task: Task(taskName: self.taskName.text ?? "", taskDescription: self.taskDescription.text ?? "",alarmDate: date.text ?? "",alarmTime: time.text ?? ""))
            dateInDate=todovm.stringToDate(date: date.text ?? "", time: time.text ?? "")
            
            UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .badge, .sound]) { success, error in
                if success{
                    self.sheduleTest(date: self.dateInDate)
                }
                else if let error=error{
                    print("error occured",error)
                    
                }
            }
        }
        else{
            self.presentingViewController?.dismiss(animated: true, completion: nil)
            self.delegate?.onbuttonTapOnEditingTask(task: Task(taskName: self.taskName.text ?? "", taskDescription: self.taskDescription.text ?? "",alarmDate: date.text ?? "",alarmTime: time.text ?? ""),index:indexPath)
            dateInDate=todovm.stringToDate(date: date.text ?? "", time: time.text ?? "")
            UNUserNotificationCenter.current().removePendingNotificationRequests(withIdentifiers: [self.taskName.text!])
            UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .badge, .sound]) { success, error in
                if success{
                    self.sheduleTest(date: self.dateInDate)
                }
                else if let error=error{
                    print("error occured",error)
                    
                }
            }
            
        }
    }
    
    func sheduleTest(date:Date){
        let content = UNMutableNotificationContent()
        content.title = self.taskName.text!
        content.sound = .default
        content.body = self.taskDescription.text!
        
        let targetDate=date
        let trigger = UNCalendarNotificationTrigger(dateMatching: Calendar.current.dateComponents([.year,.month, .day, .hour, .minute, .second], from: targetDate), repeats: false)
        let request = UNNotificationRequest(identifier: taskName.text!, content: content, trigger: trigger)
        UNUserNotificationCenter.current().add(request) { error in
            if error != nil{
                print("Something went wrong")
            }
        }
        
    }
    
    

}
