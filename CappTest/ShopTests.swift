//
//  ShopTests.swift
//  CappTest
//
//  Created by Ronak Shah on 10/16/17.
//  Copyright © 2017 Team6. All rights reserved.
//

import XCTest

class ShopTests: XCTestCase {
    
    var shop: Shop!
    
    override func setUp() {
        super.setUp()
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testToSetShopCategoryToTeaShop() {
        shop = Shop(shopTypeInit: "TEA", shopID: 01, shopName: "John's Tea", openTime: "09:30", closeTime: "22:00")
        XCTAssertEqual(String(describing: shop.getCategory()), "teaShop")
    }
    
    func testToSetShopCategoryToCoffeeShop() {
        shop = Shop(shopTypeInit: "COFFEE", shopID: 01, shopName: "John's Tea", openTime: "09:30", closeTime: "22:00")
        XCTAssertEqual(String(describing: shop.getCategory()), "coffeeShop")
    }
    
    func testToSetShopCategoryToDefault() {
        shop = Shop(shopTypeInit: "", shopID: 01, shopName: "John's Tea", openTime: "09:30", closeTime: "22:00")
        XCTAssertEqual(String(describing: shop.getCategory()), "coffeeAndTeaShop")
    }
    
    func testAddReviewAddsOneReview() {
        shop = Shop(shopTypeInit: "", shopID: 01, shopName: "John's Tea", openTime: "09:30", closeTime: "22:00")
        let review_1 = Review()
        review_1.setRating(rating: 4)
        review_1.setReviewSummary(summary: "It was good!")
        
        shop.addReview(review: review_1)
        
        XCTAssertEqual(shop.getReviews().count, 1)
        shop.shopReviews.removeAll()
    }
    
    func testAddReviewAddsTwoReviews() {
        shop = Shop(shopTypeInit: "", shopID: 01, shopName: "John's Tea", openTime: "09:30", closeTime: "22:00")
        let review_1 = Review()
        review_1.setRating(rating: 3)
        review_1.setReviewSummary(summary: "It was okay")
        shop.addReview(review: review_1)
        
        let review_2 = Review()
        review_2.setRating(rating: 2)
        review_2.setReviewSummary(summary: "Could be beter")
        shop.addReview(review: review_2)
        
        XCTAssertEqual(shop.getReviews().count, 2)
    }
    
    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
    
}
