//
//  LoginViewController.swift
//  GreenFarmMonitor
//
//  Created by Nikhil Gholap on 15/4/20.
//  Copyright © 2020 Nikhil Gholap. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController {

   weak var userDefaultController: UserdefaultsProtocol?
    weak var databaseController: DatabaseProtocol?
    
    @IBOutlet weak var loginButton: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()

        loginButton.layer.cornerRadius = 20
        loginButton.layer.borderColor = UIColor.orange.cgColor
        
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        userDefaultController = appDelegate.userDefaultController
        databaseController = appDelegate.databaseController
        
        let gradientLayer = CAGradientLayer()
        gradientLayer.frame = self.view.bounds
        
        let backgroundColor = UIColor(red: 152/255, green: 255/255, blue: 152/255, alpha: 1)
            
        gradientLayer.colors = [backgroundColor.cgColor, UIColor.white.cgColor]
        self.view.layer.insertSublayer(gradientLayer, at: 0)
        
        loginButton.backgroundColor = UIColor(red: 01, green: 1, blue: 1, alpha: 0.8)
        loginButton.layer.cornerRadius = 20
        
        // Do any additional setup after loading the view.
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        // Hide the navigation bar on the this view controller
                   self.navigationController?.setNavigationBarHidden(true, animated: true)
    }
    
    
    @IBAction func loginClicked(_ sender: Any) {
        if validateFields() {
            let newUserId = userDefaultController?.generateUniqueUserId()
            let newUser = User(userId: newUserId!, userName: "TestUser", farmLocationName: "Nashville", farmLat: "-15.55", farmLong: "141.1")
            
            // Firebase Update
            let successStatus = databaseController?.insertNewUserToFirebase(user: newUser)
            if successStatus! {
                userDefaultController?.assignName(name: newUser.userName)
            }
            
           
//            self.navigationController?.setNavigationBarHidden(true, animated: true)
            //else{
//                print("______--------------FATAL ERROR : USER CANNOT REGISTER ON FIREBASE")
//                //
//                showMessage(title: "Cannot register", message: "Please check the internet connection")
//            }
            // Set userdefaults
            
        }
    }
    
    //Validates all the fields
    func validateFields() -> Bool {
        // MARK:- Iteration -3
        return true
    }
    
    //This method shows a pop up informing changes in the information
      func showMessage(title: String, message: String) {
          let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertController.Style.alert)
          alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))
          self.present(alert, animated: true, completion: nil)
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

//// Hides the keyboard
//extension UIViewController {
//    func hideKeyboardWhenTappedAround() {
//        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(UIViewController.dismissKeyboard))
//        tap.cancelsTouchesInView = false
//        view.addGestureRecognizer(tap)
//    }
//    
//    @objc func dismissKeyboard() {
//        view.endEditing(true)
//    }
//}
