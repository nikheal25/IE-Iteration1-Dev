//
//  OnboardingViewController.swift
//  GreenFarmMonitor
//
//  Created by Nikhil Gholap on 14/4/20.
//  Copyright © 2020 Nikhil Gholap. All rights reserved.
//
import UIKit
import paper_onboarding

class OnboardingViewController: UIViewController, PaperOnboardingDataSource {
    
    weak var userDefaultController: UserdefaultsProtocol?
    weak var databaseController: DatabaseProtocol?
//    let titleFont = UIFont(name: "Nunito-Bold", size: 36.0) ?? UIFont.boldSystemFont(ofSize: 25.0)
//    let descriptionFont = UIFont(name: "OpenSans-Regular", size: 14.0) ?? UIFont.systemFont(ofSize: 14.0)
    let titleFont = UIFont(name: "SFProText-Heavy", size: 36.0) ?? UIFont.boldSystemFont(ofSize: 25.0)
    let descriptionFont = UIFont(name: "SFProText-Regular", size: 14.0) ?? UIFont.systemFont(ofSize: 14.0)
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: animated)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.setNavigationBarHidden(true, animated: animated)
    }
    
    @IBOutlet weak var nextAction: UIButton!
    
    @IBAction func onClick(_ sender: Any) {
        //        let newUserId = userDefaultController?.generateUniqueUserId()
        //        let newUser = User(userId: newUserId!, userName: "TestUser", farmLocationName: "Monash", farmLat: "-37.907803", farmLong: "145.133957")
        //
        //        // Firebase Update
        //        let successStatus = databaseController?.insertNewUserToFirebase(user: newUser)
        //        if successStatus! {
        //            userDefaultController?.assignName(name: newUser.userName)
        //        }
        
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        userDefaultController = appDelegate.userDefaultController
        databaseController = appDelegate.databaseController
        
        //TODO - CHANGE
        nextAction.isHidden = false
        
        
        let onboarding = PaperOnboarding()
        onboarding.dataSource = self
        onboarding.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(onboarding)
        
        
        // add constraints
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
        
        view.bringSubviewToFront(nextAction)
    }
    
    func onboardingItem(at index: Int) -> OnboardingItemInfo {
        
        return [
            OnboardingItemInfo(informationImage: UIImage(named: "test1_sv")!,
                               title: "Ideal Conditions",
                               description: "    Know the ideal conditions and requirements for plants    ",
                               pageIcon: UIImage(named: "test1_sv")!,
                               //Wallet
                color: UIColor(hexString: "#ffc15e"),
                titleColor: UIColor.white,
                descriptionColor: UIColor.white,
                titleFont: titleFont,
                descriptionFont: descriptionFont),
            
            OnboardingItemInfo(informationImage: UIImage(named: "naturSunday")!,
                               title: "Disease Identification",
                               description: "    Identify common plant diseases and symptoms    ",
                               pageIcon: UIImage(named: "naturSunday")!,
                               color: UIColor(hexString: "#f7934c"),   // #E85D75 - 3.5
                titleColor: UIColor.white,
                descriptionColor: UIColor.white,
                titleFont: titleFont,
                descriptionFont: descriptionFont),
            
            OnboardingItemInfo(informationImage: UIImage(named: "weather-svg-vect")!,
                               title: "Location-based Aid",
                               description: "    Receive recommendations, alerts and \n personalised solutions    ",
                               pageIcon: UIImage(named: "weather-svg-vect")!,
                               color: UIColor(hexString: "#ff9f1c"),   // #E85D75 - 3.5
                titleColor: UIColor.white,
                descriptionColor: UIColor.white,
                titleFont: titleFont,
                descriptionFont: descriptionFont)
            
            ][index]
    }
    
    
    func onboardingItemsCount() -> Int {
        return 3
    }
    
}



// MARK: PaperOnboardingDelegate
extension OnboardingViewController: PaperOnboardingDelegate {
    
    // TODO - the line below is not executing, need to make it executable
    func onboardingWillTransitonToIndex(_ index: Int) {
        //       nextAction.isHidden = index == 2 ? true : false
    }
    
    func onboardingConfigurationItem(_ item: OnboardingContentViewItem, index: Int) {
        
        // configure item
        
        //item.titleLabel?.backgroundColor = .redColor()
        //item.descriptionLabel?.backgroundColor = .redColor()
        //item.imageView = ...
    }
}

//MARK: Constants
extension OnboardingViewController {
    
    
}
