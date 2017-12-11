//
//  ShopTests.swift
//  CappTest
//
//  Created by Ronak Shah on 10/16/17.
//  Copyright ©  "35"7 Team6. All rights reserved.
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
        shop = Shop(shopType: "TEA", shopID: "35", shopName: "John's Tea", openTime: "09:30", closeTime: "22:00", tags: [])
        XCTAssertEqual(String(describing: shop.getCategory()), "teaShop")
    }
    
    func testToSetShopCategoryToCoffeeShop() {
        shop = Shop(shopType: "COFFEE", shopID: "35", shopName: "John's Tea", openTime: "09:30", closeTime: "22:00", tags: [])
        XCTAssertEqual(String(describing: shop.getCategory()), "coffeeShop")
    }
    
    func testToSetShopCategoryToDefault() {
        shop = Shop(shopType: "", shopID: "35", shopName: "John's Tea", openTime: "09:30", closeTime: "22:00", tags: [])
        XCTAssertEqual(String(describing: shop.getCategory()), "coffeeAndTeaShop")
    }
    
    func testAddReviewAddsOneReview() {
        shop = Shop(shopType: "", shopID: "35", shopName: "John's Tea", openTime: "09:30", closeTime: "22:00", tags: [])
        let review_1 = Review(r: "It was good!", rating: 4)
        
        shop.addReview(review: review_1)
        
        XCTAssertEqual(shop.getReviews().count, 1)
        shop.shopReviews.removeAll()
    }
    
    func testAddReviewAddsTwoReviews() {
        shop = Shop(shopType: "", shopID: "35", shopName: "John's Tea", openTime: "09:30", closeTime: "22:00", tags: [])
        let review_1 = Review(r: "It was okay", rating: 3)
        shop.addReview(review: review_1)
        
        let review_2 = Review(r: "Could be better", rating: 2)
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
