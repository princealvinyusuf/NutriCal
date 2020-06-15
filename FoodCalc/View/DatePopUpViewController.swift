//
//  DatePopUpViewController.swift
//  FoodCalc
//
//  Created by Muhammad Raihan on 27/05/20.
//  Copyright © 2020 Muhammad Raihan M. All rights reserved.
//

import UIKit
protocol CanReceieve {
    func passDataBack(data:String)
}

class DatePopUpViewController: UIViewController {
    
    var date: String = ""
    @IBOutlet weak var dateVIew: UIView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var saveButton: UIButton!
    @IBOutlet weak var datePicker: UIDatePicker!
    
    var delegate:CanReceieve?
    var data = ""
    override func viewDidLoad() {
        super.viewDidLoad()
        dateVIew.layer.cornerRadius = 0
        saveButton.layer.cornerRadius = 0
        datePicker.maximumDate = Date()
        accessibility()
    }
    @IBAction func dataPickerAction(_ sender: Any) {
        let format = DateFormatter()
        format.dateFormat = "dd/MM/yyyy"
        date = format.string(from: datePicker.date)
        datePicker.accessibilityLabel = date
    }
    
    @IBAction func saveButtonPressed(_ sender: UIButton) {
        print(date)
        delegate?.passDataBack(data: date)
        dismiss(animated: true)
        saveButton.accessibilityLabel = "Confirm Date"
        saveButton.accessibilityTraits = .button
    }
    
}

extension DatePopUpViewController {
    func accessibility() {
        titleLabel.font = .preferredFont(forTextStyle: .headline)
        titleLabel.adjustsFontForContentSizeCategory = true
        saveButton.titleLabel?.font = .preferredFont(forTextStyle: .headline)
        saveButton.titleLabel?.adjustsFontForContentSizeCategory = true
    }
    
}
