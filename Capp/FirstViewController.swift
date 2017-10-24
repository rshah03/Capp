//
//  FirstViewController.swift
//  Capp
//
//  Created by Ronak Shah on 10/5/17.
//  Copyright © 2017 Team6. All rights reserved.
//

import UIKit
import ChameleonFramework

class FirstViewController: UIViewController {

    var gradientLayer: CAGradientLayer!
    @IBOutlet weak var leadingC: NSLayoutConstraint!
    @IBOutlet weak var trailingC: NSLayoutConstraint!
    @IBOutlet weak var slidingView: UIView!
    
    var menuIsVisible = false

    @IBAction func menuToggler(_ sender: Any) {
        if !menuIsVisible {
            leadingC.constant = 150
            trailingC.constant = -150
            menuIsVisible = true
        } else {
            leadingC.constant = 0
            trailingC.constant = 0
            menuIsVisible = false
        }
        
        UIView.animate(withDuration: 0.2, delay: 0.0, options: .curveEaseIn, animations: {
            self.view.layoutIfNeeded()
        }) { (animationComplete) in
            print("Animation complete")
        }
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        createGradient()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func createGradient() {
        gradientLayer = CAGradientLayer()
        gradientLayer.frame = self.view.bounds
        gradientLayer.colors = [UIColor.flatBlue.cgColor, UIColor.flatSkyBlue.cgColor]
        slidingView.layer.insertSublayer(gradientLayer, at: 0)
    }


}

