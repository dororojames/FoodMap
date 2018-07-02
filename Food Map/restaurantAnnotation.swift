//
//  restaurantAnnotation.swift
//  ios_app_test
//
//  Created by Dororo on 2018/4/28.
//  Copyright © 2018年 Dororo. All rights reserved.
//

import MapKit
class restaurantAnnotation: NSObject,MKAnnotation {
    var title:String?
    var subtitle: String?
    var coordinate: CLLocationCoordinate2D
    init(title:String, subtitle:String, coordinate:CLLocationCoordinate2D) {
        self.title=title
        self.subtitle=subtitle
        self.coordinate=coordinate
    }
}
