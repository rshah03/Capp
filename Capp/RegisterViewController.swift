//
//  RegisterViewController.swift
//  Capp
//
//  Created by Ronak Shah on 10/7/17.
//  Copyright © 2017 Team6. All rights reserved.
//

import UIKit
import ChameleonFramework
import Firebase

class RegisterViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = GradientColor(.topToBottom, frame: self.view.frame, colors: [UIColor.flatGreen, UIColor.flatSandDark])
    }
    
    @IBOutlet weak var emailField: UITextField!
    @IBOutlet weak var passwordField: UITextField!
    @IBOutlet weak var confirmPasswordField: UITextField!

    @IBAction func registerButtton(_ sender: UIButton) {
        let email = emailField.text
        let unconfirmedPassword = passwordField.text
        let confirmedPassword = confirmPasswordField.text
        
        var passwordActual: String?
        
        if unconfirmedPassword == confirmedPassword {
            passwordActual = confirmedPassword
        }
        
        Auth.auth().createUser(withEmail: email!, password: passwordActual!, completion: { (user, error) in
            if error == nil {
                let alertController = UIAlertController(title: "Registered!", message: "Registration successful. You may now login.", preferredStyle: UIAlertControllerStyle.alert)
                alertController.addAction(UIAlertAction(title: "Dismiss", style: UIAlertActionStyle.default,handler: nil))
                
                self.present(alertController, animated: true, completion: nil)
            }else{
                let alertController = UIAlertController(title: "Registration Error", message: error?.localizedDescription, preferredStyle: UIAlertControllerStyle.alert)
                alertController.addAction(UIAlertAction(title: "Dismiss", style: UIAlertActionStyle.default,handler: nil))
                
                self.present(alertController, animated: true, completion: nil)
            }
            
        })
    }

    @IBAction func backToLogin(_ sender: UIBarButtonItem) {
        self.dismiss(animated: true, completion: nil)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()

    }
}
