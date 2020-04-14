//
//  OnboardingViewController.swift
//  GreenFarmMonitor
//
//  Created by Nikhil Gholap on 14/4/20.
//  Copyright © 2020 Nikhil Gholap. All rights reserved.
//

import UIKit
import  paper_onboarding

class OnboardingViewController: UIViewController, PaperOnboardingDataSource {

    let titleFont = UIFont(name: "Nunito-Bold", size: 36.0) ?? UIFont.boldSystemFont(ofSize: 25.0)
    let descriptionFont = UIFont(name: "OpenSans-Regular", size: 14.0) ?? UIFont.systemFont(ofSize: 14.0)
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: animated)
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.setNavigationBarHidden(false, animated: animated)
    }

    @IBOutlet weak var nectAction: UIButton!
    
    @IBAction func nextButtonClicked(_ sender: Any) {
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        
        nectAction.isHidden = true
        
        
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
        
         view.bringSubviewToFront(nectAction)
                }
             
    func onboardingItem(at index: Int) -> OnboardingItemInfo {

               return [
                OnboardingItemInfo(informationImage: UIImage(named: "Stores")!,
                                               title: "Ideal condition for a crop",
                                         description: "Find out the ideal conditions for your crop",
                                         pageIcon: UIImage(named: "Stores")!,
                                         color: UIColor(hexString: "#588B8B"),
                                          titleColor: UIColor.white,
                                          descriptionColor: UIColor.white,
                                    titleFont: titleFont,
                                    descriptionFont: descriptionFont),

                OnboardingItemInfo(informationImage: UIImage(named: "temp")!,
                           title: "Crop disease Detection",
                     description: "Know more about diseases that may affect  your crop",
                     pageIcon: UIImage(named: "temp")!,
                           color: UIColor.red,
                      titleColor: UIColor.white,
                descriptionColor: UIColor.white,
                       titleFont: titleFont,
                       descriptionFont: descriptionFont),
                
                OnboardingItemInfo(informationImage: UIImage(named: "temp")!,
                           title: "Buy Organic",
                     description: "Get suggestions regarding the best Organic products in market",
                     pageIcon: UIImage(named: "temp")!,
                           color: UIColor.red,
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

        extension UIColor {
        convenience init(hexString: String, alpha: CGFloat = 1.0) {
            let hexString: String = hexString.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines)
            let scanner = Scanner(string: hexString)
            if (hexString.hasPrefix("#")) {
                scanner.scanLocation = 1
            }
            var color: UInt32 = 0
            scanner.scanHexInt32(&color)
            let mask = 0x000000FF
            let r = Int(color >> 16) & mask
            let g = Int(color >> 8) & mask
            let b = Int(color) & mask
            let red   = CGFloat(r) / 255.0
            let green = CGFloat(g) / 255.0
            let blue  = CGFloat(b) / 255.0
            self.init(red:red, green:green, blue:blue, alpha:alpha)
        }
        func toHexString() -> String {
            var r:CGFloat = 0
            var g:CGFloat = 0
            var b:CGFloat = 0
            var a:CGFloat = 0
            getRed(&r, green: &g, blue: &b, alpha: &a)
            let rgb:Int = (Int)(r*255)<<16 | (Int)(g*255)<<8 | (Int)(b*255)<<0
            return String(format:"#%06x", rgb)
        }
        }


// MARK: PaperOnboardingDelegate

extension OnboardingViewController: PaperOnboardingDelegate {

    // TODO - the line below is not executing, need to make it executable
    func onboardingWillTransitonToIndex(_ index: Int) {
        nectAction.isHidden = index == 2 ? true : false
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

