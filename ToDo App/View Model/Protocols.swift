//
//  Protocols.swift
//  ToDo App
//
//  Created by Julien on 12/10/21.
//

import Foundation
protocol OnButtonTapAddTaskWindow{
    func onbuttonTapOnAddingTask(task:Task)
    func onbuttonTapOnEditingTask(task:Task,index:IndexPath)
}

protocol TaskAddorEditDelegate{
    func didTapDeleteTask(at index:IndexPath)
    func didTapEditTask(at index:IndexPath)
    func didTapRadioButton(at index: IndexPath)
    
}
