//
//  Review.swift
//  Capp
//
//  Created by Ronak Shah on 10/12/17.
//  Copyright © 2017 Team6. All rights reserved.
//

import Foundation

class Review: Codable {
    
    var starRating: Int
    var reviewSummary: String
    
    init(r: String, rating: Int) {
        starRating = rating
        reviewSummary = r
    }
    
    func setRating(rating: Int) {
        if rating == 0 {
            starRating = 1
        }
        else {
            starRating = rating
        }
    }
    
    func getRating() -> Int {
        return starRating
    }
    
    func setReviewSummary(summary: String) {
        reviewSummary = summary
    }
    
    func getReviewSummary() -> String {
        return reviewSummary
    }
}
