//
//  RegisterViewController.swift
//  Capp
//
//  Created by Ronak Shah on 10/7/17.
//  Copyright © 2017 Team6. All rights reserved.
//

import UIKit
import ChameleonFramework

class RegisterViewController: UIViewController {

    var gradientLayer: CAGradientLayer!

    @IBAction func backToLogin(_ sender: UIBarButtonItem) {
        self.dismiss(animated: true, completion: nil)
    }
    

    override func viewDidLoad() {
        super.viewDidLoad()
        createGradient()

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()

    }
    
    func createGradient() {
        gradientLayer = CAGradientLayer()
        gradientLayer.frame = self.view.bounds
        gradientLayer.colors = [UIColor.flatSkyBlue.cgColor, UIColor.flatBlue.cgColor]
        self.view.layer.insertSublayer(gradientLayer, at: 0)
    }

}
