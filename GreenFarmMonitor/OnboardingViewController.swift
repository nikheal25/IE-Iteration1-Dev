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

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: animated)
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.setNavigationBarHidden(false, animated: animated)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

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
                }
              func onboardingItem(at index: Int) -> OnboardingItemInfo {

               return [
                OnboardingItemInfo(informationImage: UIImage(named: "temp")!,
                                               title: "title",
                                         description: "description",
                                         pageIcon: UIImage(named: "temp")!,
                                         color: UIColor(hexString: "#3f3f3f"),
                                          titleColor: UIColor.red,
                                    descriptionColor: UIColor.red,
                                    titleFont: UIFont(name: "OpenSans-Regular", size: 14.0) ?? UIFont.systemFont(ofSize: 14.0), descriptionFont: UIFont(name: "OpenSans-Regular", size: 14.0) ?? UIFont.systemFont(ofSize: 14.0)),

                OnboardingItemInfo(informationImage: UIImage(named: "temp")!,
                           title: "title",
                     description: "description",
                     pageIcon: UIImage(named: "temp")!,
                           color: UIColor.red,
                      titleColor: UIColor.red,
                descriptionColor: UIColor.red,
                       titleFont: UIFont(name: "OpenSans-Regular", size: 14.0) ?? UIFont.systemFont(ofSize: 14.0), descriptionFont: UIFont(name: "OpenSans-Regular", size: 14.0) ?? UIFont.systemFont(ofSize: 14.0)),
                
                OnboardingItemInfo(informationImage: UIImage(named: "temp")!,
                           title: "title",
                     description: "description",
                     pageIcon: UIImage(named: "temp")!,
                           color: UIColor.red,
                      titleColor: UIColor.red,
                descriptionColor: UIColor.red,
                       titleFont: UIFont(name: "OpenSans-Regular", size: 14.0) ?? UIFont.systemFont(ofSize: 14.0), descriptionFont: UIFont(name: "OpenSans-Regular", size: 14.0) ?? UIFont.systemFont(ofSize: 14.0))

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
