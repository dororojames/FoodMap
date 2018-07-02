//
//  Restaurant.swift
//  database
//
//  Created by Dororo on 2018/6/8.
//  Copyright © 2018年 LLF. All rights reserved.
//

import Foundation
import MapKit

class RestaurantList {
    var restaurants = [Restaurants]()
    var alltags = [String]()
    var filterlist = [Restaurants]()
    var annotationlist = [restaurantAnnotation]()
    var mapview:MapViewController!
    func listRestaurants() -> Void {
        annotationlist.removeAll()
        for r in filterlist{
            print(r.r_ID!,r.name!)
            print((r.price_low)!,(r.price_high)!)
            for tag in r.tag as! Set<Tags>{
                print(tag.tag!)
                if !alltags.contains(tag.tag!){
                    alltags.append(tag.tag!)
                }
                if r.firstTag == nil{
                    r.firstTag = tag.tag!
                }
            }
            for Con in r.contact as! Set<Contacts>{
                print(Con.contact!)
            }
//            for Opt in r.opentime as! Set<Opentime>{
//                print(Opt.day!)
//                print(Opt.timeslot!)
//            }
            annotationlist.append(restaurantAnnotation(title: r.name!, subtitle: r.firstTag!, coordinate: CLLocationCoordinate2DMake(Double(r.latitude!)!, Double(r.longitude!)!)))
        }
    }
    func filter(selecttag: String,price_low: Int,price_high: Int,distance_low: Double,distance_high: Double,locaton:CLLocation) ->Bool{
        filterlist.removeAll()
        print(selecttag,price_low,price_high,distance_low,distance_high,locaton.coordinate)
        for r in restaurants {
            var filter: Bool = false
            for tag in r.tag as! Set<Tags>{
                if tag.tag! == selecttag{
                    filter = true
                    break
                }
            }
            if filter && (price_low > r.price_high! || price_high < r.price_high!){
                filter = false
            }
            if filter{
                let d = distance(x1: locaton.coordinate.latitude, y1: locaton.coordinate.longitude, x2: Double(r.latitude!)!, y2: Double(r.longitude!)!)
                print("d=",d, Double(r.latitude!)!, Double(r.longitude!)!)
                if d < distance_low || d > distance_high{
                    filter = false
                }
            }
            if filter {filterlist.append(r)}
        }
        if filterlist.count == 0{
            print("nothing filter")
            filterlist = restaurants
            self.listRestaurants()
            return false
        }
        self.listRestaurants()
        return true
    }
}
func distance(x1:Double,y1:Double,x2:Double,y2:Double)->Double
{
    let p = 0.017453292519943295
    let a = 0.5 - cos((x2-x1)*p)/2 + cos(x1*p)*cos(x2*p)*(1-cos((y2-y1)*p)/2)
    return 450*asin(sqrt(a))
}
