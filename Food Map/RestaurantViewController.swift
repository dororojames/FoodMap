//
//  RestaurantViewController.swift
//  LifeApp
//
//  Created by Dororo on 2018/6/9.
//  Copyright © 2018年 Student. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation

class RestaurantViewController: UIViewController, CLLocationManagerDelegate {
    @IBOutlet weak var Name: UILabel!
    @IBOutlet weak var Tag: UILabel!
    @IBOutlet weak var isOpen: UILabel!
    @IBOutlet weak var Address: UILabel!
    
    @IBAction func Back(_ sender: Any) {
        self.view.window?.rootViewController?.dismiss(animated: true, completion: nil)
    }
    var restaurant:Restaurants!
    var annotation: restaurantAnnotation!
    
    @IBOutlet weak var navbar: UINavigationBar!
    @IBOutlet weak var mapView: MKMapView!
    let locationManager = CLLocationManager()
    override func viewDidLoad() {
        super.viewDidLoad()
        locationManager.delegate = self
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()
        mapView.setRegion(MKCoordinateRegionMakeWithDistance(annotation.coordinate, 3000, 3000), animated: true)
        mapView.addAnnotation(annotation)
        navbar.topItem?.title = restaurant.name
        Name.text = restaurant.name
        Tag.text = restaurant.firstTag
        Address.text = restaurant.address
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        mapView.showsUserLocation = true
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showDetail"{
            let controller = segue.destination as! RestaurantDetailViewController
            controller.restaurant = self.restaurant
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
