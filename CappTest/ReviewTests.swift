//
//  ReviewTests.swift
//  CappTest
//
//  Created by Ronak Shah on 10/15/17.
//  Copyright © 2017 Team6. All rights reserved.
//

import XCTest

class ReviewTests: XCTestCase {
    
    var review = Review(r: "", rating: 0)
    
    override func setUp() {
        super.setUp()
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testSetRatingWhenRatingIsZero() {
        review.setRating(rating: 0)
        XCTAssertEqual(review.getRating(), 1)
    }
    
    func testSetRating() {
        review.setRating(rating: 5)
        XCTAssertEqual(review.getRating(), 5)
    }
    
    func testSetReviewSummary() {
        let text = "Lorem Ipsum"
        review.setReviewSummary(summary: "Lorem Ipsum")
        XCTAssertEqual(review.getReviewSummary(), text)
    }
    
    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
    
}
