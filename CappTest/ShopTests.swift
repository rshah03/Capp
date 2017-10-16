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
    
    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
    
}
