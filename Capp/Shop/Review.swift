//
//  Review.swift
//  Capp
//
//  Created by Ronak Shah on 10/12/17.
//  Copyright © 2017 Team6. All rights reserved.
//

import Foundation

class Review {
    
    var starRating: Int
    var reviewSummary: String
    
    init() {
        starRating = 0
        reviewSummary = ""
    }
    
    func setRating(rating: Int) {
         starRating = rating
    }
    
    func getRating() -> Int {
        return starRating
    }
    
    func setReviewSummary(summary: String) {
        reviewSummary = summary
    }
}
