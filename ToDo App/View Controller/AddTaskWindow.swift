//
//  AddTaskWindow.swift
//  ToDo App
//
//  Created by Julien on 11/10/21.
//

import UIKit

class AddTaskWindow: UIViewController {
    @IBOutlet var taskName: UITextField?{
        didSet{
            if(oldValue?.text!==nil){
                taskNameBeforeEditing=oldValue?.text
            }
        }
    }
    @IBOutlet var taskDescription: UITextField!
    @IBOutlet var dateTime: UITextField?
    @IBOutlet var dateTimePicker: UIDatePicker!
    
    var delegate:OnButtonTapAddTaskWindow?
    var indexPath:IndexPath!
    var isSelectedAlarm:Bool=false
    var isfromediting:Bool=false
    var taskNameForEdit:String?
    var taskDescriptionForEdit:String?
    var taskDateTimeForEditing:String?
    var taskNameBeforeEditing:String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        dateTime?.isUserInteractionEnabled=false
        if(isfromediting){
            taskName!.text=taskNameForEdit
            taskDescription.text=taskDescriptionForEdit
            dateTime?.text=taskDateTimeForEditing
        }
        self.dateTimePicker.addTarget(self, action: #selector(dateTimePickerValueChanged), for: UIControl.Event.valueChanged)
    }
    
    @IBAction func didTapCancelButton(_ sender: UIButton) {
        if(isfromediting){
            sheduleTest()
        }
        self.presentingViewController?.dismiss(animated: true, completion: nil)
        
    }
    @IBAction func didTapAddButton(_ sender: UIButton) {
        if dateTime?.text != ""{
            isSelectedAlarm=true
            comingFromAddOrEditCheck()
        }
        else{
            isSelectedAlarm=false
            comingFromAddOrEditCheck()
        }
    }
    @objc func dateTimePickerValueChanged(){
        let formatter = DateFormatter()
        formatter.dateFormat = "dd/MM/yyyy HH:mm"
        dateTime?.text = formatter.string(from: dateTimePicker.date)
    }
    
    func comingFromAddOrEditCheck(){
        if(isfromediting==false){
            self.presentingViewController?.dismiss(animated: true, completion: nil)
            self.delegate?.onbuttonTapOnAddingTask(task: Task(taskName: self.taskName!.text ?? "", taskDescription: self.taskDescription.text ?? "",alarmDateTime: dateTime?.text ?? "",isAlarmSet: isSelectedAlarm),isAlarmSet: isSelectedAlarm)
            UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .badge, .sound]) { success, error in
                if success{
                    self.sheduleTest()
                }
                else if let error=error{
                    print("error occured",error)
                }
            }
        }
        else{
            self.presentingViewController?.dismiss(animated: true, completion: nil)
            self.delegate?.onbuttonTapOnEditingTask(task: Task(taskName: self.taskName!.text ?? "", taskDescription: self.taskDescription.text ?? "",alarmDateTime: dateTime?.text ?? "",isAlarmSet:isSelectedAlarm),index:indexPath)
            //UNUserNotificationCenter.current().removePendingNotificationRequests(withIdentifiers: [self.taskNameBeforeEditing!])
            UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .badge, .sound]) { success, error in
                if success{
                    self.sheduleTest()
                }
                else if let error=error{
                    print("error occured",error)
                }
            }
        }
    }
    
    func sheduleTest(){
        DispatchQueue.main.async {
            let content = UNMutableNotificationContent()
            content.title = self.taskName!.text!
            content.sound = .default
            content.body = self.taskDescription.text!
            let targetDate = self.dateTimePicker.date
            let trigger = UNCalendarNotificationTrigger(dateMatching: Calendar.current.dateComponents([.year,.month, .day, .hour, .minute], from: targetDate), repeats: false)
            let request = UNNotificationRequest(identifier: self.taskName!.text!, content: content, trigger: trigger)
            UNUserNotificationCenter.current().add(request) { error in
                if error != nil{
                    print("Something went wrong")
                }
            }
        }
        
    }
//    func sheduleTest(){
//        let content = UNMutableNotificationContent()
//        content.title = "Title"
//        content.body = "Body"
//        content.sound = .default
//
//        let gregorian = Calendar(identifier: .gregorian)
//        let now = Date()
//        var components = gregorian.dateComponents([.year, .month, .day, .hour, .minute, .second], from: now)
//
//        // Change the time to 7:00:00 in your locale
//        components.hour = 7
//        components.minute = 0
//        components.second = 0
//
//        let date = gregorian.date(from: components)!
//
//        let triggerDaily = Calendar.current.dateComponents([.hour,.minute,.second,], from: date)
//        let trigger = UNCalendarNotificationTrigger(dateMatching: triggerDaily, repeats: true)
//
//
//        let request = UNNotificationRequest(identifier: "jjt", content: content, trigger: trigger)
//        print("INSIDE NOTIFICATION")
//
//        UNUserNotificationCenter.current().add(request, withCompletionHandler: {(error) in
//            if let error = error {
//                print("SOMETHING WENT WRONG")
//            }
//        })
//    }
    
//    func sheduleTest(){
//        let content = UNMutableNotificationContent()
//        content.title = "Weekly Staff Meeting"
//        content.body = "Every Tuesday at 2pm"
//
////        var date = DateComponents()
////        date.timeZone = .current
////        date.hour = 13
////        date.minute = 23
//        var date=Date().addingTimeInterval(10)
//        let trigger = UNCalendarNotificationTrigger(dateMatching: Calendar.current.dateComponents([.year,.month, .day, .hour, .minute,.second], from: date), repeats: true)
//
//        let uuidString = UUID().uuidString
//        let request = UNNotificationRequest(identifier: uuidString,
//                    content: content, trigger: trigger)
//
//        // Schedule the request with the system.
//        let notificationCenter = UNUserNotificationCenter.current()
//        notificationCenter.add(request) { (error) in
//            print("Notification Added")
//           if error != nil {
//              // Handle any errors.
//           }
//        }
//    }
}
