//
//  IntroViewController.swift
//  Timo
//
//  Created by Prince Alvin Yusuf on 30/03/20.
//  Copyright © 2020 sambalpete. All rights reserved.
//

import UIKit

class IntroViewController: UIViewController {
    @IBOutlet weak var skipButton: UIButton!
    
    fileprivate let items = [
        OnboardingItemInfo(informationImage: Asset.illustrate1.image,
                           title: "Identify Foods",
                           description: "You can identify the foods you don’t know through your iPhone camera or gallery",
                           pageIcon: Asset.indicator1.image,
                           color: UIColor.systemBackground,
                           titleColor: UIColor.label, descriptionColor: UIColor.label, titleFont: titleFont, descriptionFont: descriptionFont),
        
        OnboardingItemInfo(informationImage: Asset.illustrate2.image,
                           title: "Explore Your Food Nutrients",
                           description: "Let’s learn about nutrient content in your food through your iPhone camera or typing a keyword",
                           pageIcon: Asset.indicator2.image,
                           color: UIColor.systemBackground,
                           titleColor: UIColor.label, descriptionColor: UIColor.label, titleFont: titleFont, descriptionFont: descriptionFont),
        
        OnboardingItemInfo(informationImage: Asset.illustrate3.image,
                           title: "Know Your Daily Nutrition Intake",
                           description: "Let’s summarize your nutrient intakes in a whole day",
                           pageIcon: Asset.indicator3.image,
                           color: UIColor.systemBackground,
                           titleColor: UIColor.label, descriptionColor: UIColor.label, titleFont: titleFont, descriptionFont: descriptionFont),
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        skipButton.isHidden = true
        
        setupPaperOnboardingView()
        
        view.bringSubviewToFront(skipButton)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    private func setupPaperOnboardingView() {
        let onboarding = PaperOnboarding()
        onboarding.delegate = self
        onboarding.dataSource = self
        onboarding.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(onboarding)
        
        // Add constraints
        for attribute: NSLayoutConstraint.Attribute in [.left, .right, .top, .bottom] {
            let constraint = NSLayoutConstraint(item: onboarding,
                                                attribute: attribute,
                                                relatedBy: .equal,
                                                toItem: view,
                                                attribute: attribute,
                                                multiplier: 1,
                                                constant: 0)
            view.addConstraint(constraint)
        }
    }
}

// MARK: Actions

extension IntroViewController {
    @IBAction func skipButtonTapped(_: UIButton) {
        print(#function)
        print("button skip")
        
        //Pergi ke menu utama
        performSegue(withIdentifier: "gotomainmenu", sender: nil)
    }
}

// MARK: PaperOnboardingDelegate

extension IntroViewController: PaperOnboardingDelegate {
    func onboardingWillTransitonToIndex(_ index: Int) {
        skipButton.isHidden = index == 2 ? false : true
    }
    
    func onboardingDidTransitonToIndex(_: Int) {
    }
    
    func onboardingConfigurationItem(_ item: OnboardingContentViewItem, index: Int) {
        
    }
}

// MARK: PaperOnboardingDataSource

extension IntroViewController: PaperOnboardingDataSource {
    func onboardingItem(at index: Int) -> OnboardingItemInfo {
        return items[index]
    }
    
    func onboardingItemsCount() -> Int {
        return 3
    }
    
}


//MARK: Constants
extension IntroViewController {
    private static let titleFont = UIFont(name: "Nunito-Bold", size: 24.0) ?? UIFont.boldSystemFont(ofSize: 24.0)
    private static let descriptionFont = UIFont(name: "sans-serif", size: 20.0) ?? UIFont.systemFont(ofSize: 20.0)
}
