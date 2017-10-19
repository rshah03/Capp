//
//  UserTests.swift
//  CappTest
//
//  Created by Ronak Shah on 10/17/17.
//  Copyright © 2017 Team6. All rights reserved.
//

import XCTest

class UserTests: XCTestCase {
    
    var user: User!
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
        user = User(email: "john@apple.com", password: "1234", favoriteShops: [])
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testIfAddToFavoritesAddsOneShop() {
        let shop = Shop(shopTypeInit: "tea", shopID: 01, shopName: "Appleseed Coffee", openTime: "08:00", closeTime: "20:00")
        user.addToFavorites(shopToAdd: shop)
        XCTAssertEqual(user.getFavorites().count, 1)
    }
    
    func testIfAddToFavoritesAddsMultipleShops() {
        let shop_1 = Shop(shopTypeInit: "tea", shopID: 01, shopName: "Appleseed Coffee", openTime: "08:00", closeTime: "20:00")
        let shop_2 = Shop(shopTypeInit: "coffee", shopID: 02, shopName: "Jane's Coffee", openTime: "08:00", closeTime: "20:00")
        user.addToFavorites(shopToAdd: shop_1)
        user.addToFavorites(shopToAdd: shop_2)
        XCTAssertEqual(user.getFavorites().count, 2)
    }
    
    func testIfAddToFavoritesDoesNotAddDuplicates() {
        let shop_1 = Shop(shopTypeInit: "tea", shopID: 01, shopName: "Appleseed Coffee", openTime: "08:00", closeTime: "20:00")
        let shop_2 = shop_1
        user.addToFavorites(shopToAdd: shop_1)
        user.addToFavorites(shopToAdd: shop_2)
        XCTAssertEqual(user.getFavorites().count, 1)
    }
    
    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
    
}