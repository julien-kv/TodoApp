//
//  TodoTableViewCell.swift
//  ToDo App
//
//  Created by Julien on 07/10/21.
//

import UIKit
import DLRadioButton

class TodoTableViewCell: UITableViewCell{
    @IBOutlet var taskName: UILabel!
    @IBOutlet var taskDescription: UILabel!
    
    @IBOutlet var taskCellView: UIView!
    @IBOutlet var DeleteButton: UIButton!
    @IBOutlet var EditButton: UIButton!
    @IBOutlet var RadioButton: DLRadioButton!
    
    @IBOutlet var cell: UIView!
    @IBOutlet var alarmButton: UIButton!
    static let cellIdentifier="taskcell"
    var delegate:TaskAddorEditDelegate?
    var indexPath:IndexPath!
    
    @IBAction func didTapRadioButton(_ sender: UIButton) {
        delegate?.didTapRadioButton(at: indexPath)

    }
    
    @IBAction func didTapEditButton(_ sender: UIButton) {
        delegate?.didTapEditTask(at: indexPath)
    }
    
    @IBAction func didTapDeleteButton(_ sender: UIButton) {
        delegate?.didTapDeleteTask(at: indexPath)
    }
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        taskCellView.frame = contentView.frame.inset(by: UIEdgeInsets(top: 8, left: 8, bottom: 8, right: 8))
        
        cell.layer.masksToBounds=false
        cell.layer.cornerRadius=10
        cell.layer.shadowColor = UIColor.black.cgColor
        cell.layer.shadowOpacity = 0.1
        cell.layer.shadowOffset = CGSize(width: CGFloat(0.0), height: CGFloat(2.0))
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
