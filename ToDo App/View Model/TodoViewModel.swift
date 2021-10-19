//
//  TaskViewModel.swift
//  ToDo App
//
//  Created by Julien on 12/10/21.
//

import Foundation
protocol onDeleteConfirmedProtocol{
    func onDeleteConfirmedButtonClicked(index:IndexPath)
}

protocol OnButtonTapAddTaskWindow{
    func onbuttonTapOnAddingTask(task:Task,isAlarmSet:Bool)
    func onbuttonTapOnEditingTask(task:Task,index:IndexPath)
}

protocol TaskAddorEditDelegate{
    func didTapDeleteTask(at index:IndexPath)
    func didTapEditTask(at index:IndexPath)
    func didTapRadioButton(at index: IndexPath)
    
}

protocol AlarmSettingProtocol{
    func isAlarmSelected(isAlarmSet:Bool)
}

class TodoViewModel{
    
    func stringToDate(date:String,time:String)->Date{
        let string="\(date) \(time)"

        // Create Date Formatter
        let dateFormatter = DateFormatter()

        // Set Date Format
        dateFormatter.dateFormat = "dd-MM-yyyy HH:mm a"
        // Convert String to Date
   return dateFormatter.date(from: string)!
    }
}
