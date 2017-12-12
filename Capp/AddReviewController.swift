//
//  AddReviewControllerViewController.swift
//  Capp
//
//  Created by Ethan on 12/11/17.
//  Copyright © 2017 Team6. All rights reserved.
//

import UIKit

class AddReviewController: UIViewController, UITextViewDelegate {
    var shop:Shop?
    var review = Review(r: "", rating: -1)
    
    @IBAction func rating(_ sender: UISegmentedControl) {
        review.setRating(rating: sender.selectedSegmentIndex+1)
    }
    @IBOutlet weak var reviewText: UITextView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        reviewText.delegate = self
        reviewText.text = "Add Review..."
        reviewText.textColor = UIColor.lightGray
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Done", style: .plain, target: self, action: #selector (reviewComplete))
        // Do any additional setup after loading the view.
    }
    
    func textViewDidBeginEditing(_ textView: UITextView) {
        if textView.textColor == UIColor.lightGray {
            textView.text = nil
            textView.textColor = UIColor.black
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @objc func reviewComplete(){
        if reviewText.textColor == UIColor.lightGray || reviewText.text.isEmpty{
            let alertController = UIAlertController(title: "No Text in Review", message: "Please write something in your review.", preferredStyle: UIAlertControllerStyle.alert)
            alertController.addAction(UIAlertAction(title: "Dismiss", style: UIAlertActionStyle.default,handler: nil))
            self.present(alertController, animated: true, completion: nil)
        }
        else if review.getRating() == -1 {
            let alertController = UIAlertController(title: "No Rating Given", message: "Please add a rating to your review", preferredStyle: UIAlertControllerStyle.alert)
            alertController.addAction(UIAlertAction(title: "Dismiss", style: UIAlertActionStyle.default,handler: nil))
            self.present(alertController, animated: true, completion: nil)
        }
        else {
            review.setReviewSummary(summary: reviewText.text)
            shop!.addReview(review: review)
            _ = navigationController?.popViewController(animated: true)
            _ = navigationController?.popViewController(animated: true)
        }
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
