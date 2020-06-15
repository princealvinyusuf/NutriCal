//
//  AboutViewController.swift
//  NutriCal
//
//  Created by Prince Alvin Yusuf on 09/06/20.
//  Copyright © 2020 Prince Alvin Yusuf. All rights reserved.
//

import UIKit

class AboutViewController: UIViewController {
    
    @IBOutlet weak var aboutNutrical: UITextView!
    @IBOutlet weak var titleNutrical: UILabel!
    @IBOutlet weak var developerTeam: UILabel!
    
    @IBOutlet weak var andriWijaya: UILabel!
    @IBOutlet weak var edrickLim: UILabel!
    @IBOutlet weak var raihan: UILabel!
    @IBOutlet weak var dipta: UILabel!
    @IBOutlet weak var alvin: UILabel!
    @IBOutlet weak var rian: UILabel!
    @IBOutlet var nutricalLogo: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        applyAccessibility()
        //Localization
        self.navigationItem.title = NSLocalizedString("about_title", comment: "")
        developerTeam.text = NSLocalizedString("about_developer", comment: "")
        aboutNutrical.text = NSLocalizedString("about_description", comment: "")
    }
    
    
}

extension AboutViewController {
    func applyAccessibility() {
        aboutNutrical.font = .preferredFont(forTextStyle: .body)
        aboutNutrical.adjustsFontForContentSizeCategory = true
        titleNutrical.font = .preferredFont(forTextStyle: .largeTitle)
        titleNutrical.adjustsFontForContentSizeCategory = true
        developerTeam.font = .preferredFont(forTextStyle: .largeTitle)
        developerTeam.adjustsFontForContentSizeCategory = true
        andriWijaya.font = .preferredFont(forTextStyle: .body)
        andriWijaya.adjustsFontForContentSizeCategory = true
        edrickLim.font = .preferredFont(forTextStyle: .body)
        edrickLim.adjustsFontForContentSizeCategory = true
        raihan.font = .preferredFont(forTextStyle: .body)
        raihan.adjustsFontForContentSizeCategory = true
        dipta.font = .preferredFont(forTextStyle: .body)
        dipta.adjustsFontForContentSizeCategory = true
        alvin.font = .preferredFont(forTextStyle: .body)
        alvin.adjustsFontForContentSizeCategory = true
        rian.font = .preferredFont(forTextStyle: .body)
        rian.adjustsFontForContentSizeCategory = true
        
        aboutNutrical.isAccessibilityElement = true
        aboutNutrical.accessibilityTraits = .none
        
        nutricalLogo.isAccessibilityElement = true
        nutricalLogo.accessibilityTraits = .image
        nutricalLogo.accessibilityLabel = "NutriCal Logo"
    }
}


