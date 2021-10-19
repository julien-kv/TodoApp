//
//  DeleteTaskViewController.swift
//  ToDo App
//
//  Created by Julien on 18/10/21.
//

import UIKit

class DeleteTaskViewController: UIViewController {
    var index:IndexPath!
    var delegate:onDeleteConfirmedProtocol?

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func didTapCancelButton(_ sender: UIButton) {
        self.presentingViewController?.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func didTapDeleteButton(_ sender: UIButton) {
        delegate?.onDeleteConfirmedButtonClicked(index: index)
        self.presentingViewController?.dismiss(animated: true, completion: nil)
    }
    
     @IBAction func didTapCloseButton(_ sender: Any) {
         self.presentingViewController?.dismiss(animated: true, completion: nil)
     }
    /*
     // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
