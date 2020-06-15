//
//  SupportedFoodViewController.swift
//  NutriCal
//
//  Created by Prince Alvin Yusuf on 11/06/20.
//  Copyright © 2020 Prince Alvin Yusuf. All rights reserved.
//

import UIKit

class SupportedFoodViewController: UIViewController {
    
    @IBOutlet weak var listLabel: UILabel!
    @IBOutlet weak var contentFood: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        accessibility()
    }
    
    
}

extension SupportedFoodViewController {
    func accessibility(){
        listLabel.font = .preferredFont(forTextStyle: .headline)
        listLabel.adjustsFontForContentSizeCategory = true
        
        contentFood.font = .preferredFont(forTextStyle: .subheadline)
        contentFood.adjustsFontForContentSizeCategory = true
        
        contentFood.isAccessibilityElement = true
    }
}
