//
//  LoginViewController.swift
//  Capp
//
//  Created by Ronak Shah on 10/5/17.
//  Copyright © 2017 Team6. All rights reserved.
//

import UIKit
import SnapKit
import ChameleonFramework

class LoginViewController: UIViewController {
    
    var gradientLayer: CAGradientLayer!
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        createGradient()
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.

    }
    
    func createGradient() {
        gradientLayer = CAGradientLayer()
        gradientLayer.frame = self.view.bounds
//        gradientLayer.colors = [FlatCoffee().cgColor, FlatWhite().cgColor]
        gradientLayer.colors = [UIColor.flatBlue.cgColor, UIColor.flatSkyBlue.cgColor]
        self.view.layer.insertSublayer(gradientLayer, at: 0)
    }
    
    
}
