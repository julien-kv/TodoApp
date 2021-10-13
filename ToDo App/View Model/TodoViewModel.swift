//
//  TaskViewModel.swift
//  ToDo App
//
//  Created by Julien on 12/10/21.
//

import Foundation
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

//func saveTodoListtoUserDefault(taskArray:[Task]){
//    do {
//        let encoder = JSONEncoder()
//        let data = try encoder.encode(taskArray)
//        UserDefaults.standard.set(data, forKey: "todoList")
//    } catch {
//        print("Unable to Encode CrossPromoPopUpDict (\(error))")
//    }
//}


//
//func saveCrossPromoDictToUserDefault(crossPromoDict: [String: CrossPromoPopUpLimit]) {
//        do {
//            let encoder = JSONEncoder()
//            let data = try encoder.encode(crossPromoDict)
//            UserDefaults.standard.set(data, forKey: "crossPromoPopUpDict")
//        } catch {
//            print("Unable to Encode CrossPromoPopUpDict (\(error))")
//        }
//    }
//
//    func fetchCrossPromoDictFromUserDefault() -> [String: CrossPromoPopUpLimit]? {
//        if let data = UserDefaults.standard.data(forKey: "crossPromoPopUpDict") {
//            do {
//                let decoder = JSONDecoder()
//                let dict = try decoder.decode([String: CrossPromoPopUpLimit].self, from: data)
//                return dict
//            } catch {
//                print("Unable to Decode Notes (\(error))")
//                return nil
//            }
//        } else {
//            return nil
//        }
//    }
