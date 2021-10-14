//
//  TaskModel.swift
//  ToDo App
//
//  Created by Julien on 08/10/21.
//

import Foundation

struct Task:Codable{
    var taskName:String
    var taskDescription:String
    var alarmDateTime:String?
    var isAlarmSet:Bool
}
