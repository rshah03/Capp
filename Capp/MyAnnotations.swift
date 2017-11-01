//
//  MyAnnotations.swift
//  Capp
//
//  Created by Chao Yang on 10/30/17.
//  Copyright © 2017 Team6. All rights reserved.
//

import UIKit
import MapKit

class MyAnnotations: NSObject, MKAnnotation {
    var coordinate: CLLocationCoordinate2D = CLLocationCoordinate2DMake(0, 0)
    var title: String?
    
    init(coordinate: CLLocationCoordinate2D, title: String) {
        self.coordinate = coordinate
        self.title = title
    }
    
}
