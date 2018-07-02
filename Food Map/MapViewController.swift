//
//  MapViewController.swift
//  LifeApp
//
//  Created by Dororo on 2018/6/1.
//  Copyright © 2018年 Student. All rights reserved.
//

import Foundation
import UIKit
import MapKit
import CoreData
import CoreLocation

class tableCell: UITableViewCell
{
    @IBOutlet weak var Name: UILabel!
    @IBOutlet weak var Address: UILabel!
}

class MapViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, CLLocationManagerDelegate {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return restaurantlist.filterlist.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "restaurantCell", for: indexPath) as! tableCell
        cell.Name?.text = restaurantlist.filterlist[indexPath.row].name
        cell.Address?.text = restaurantlist.filterlist[indexPath.row].address
        return cell
    }
    
    var restaurantlist = RestaurantList()
    @IBOutlet weak var mapView: MKMapView!
    
    @IBAction func roll(for segue: UIStoryboardSegue) {
    }
    
    @IBAction func unwindToselect(for segue: UIStoryboardSegue) {
    }
    
    @IBOutlet weak var tableView: UITableView!
    var app = UIApplication.shared.delegate as! AppDelegate
    var viewContext: NSManagedObjectContext!
    let locationManager = CLLocationManager()
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        locationManager.delegate = self
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()
        let TABLE = table(app: app)
        TABLE.getlist(restlist: &restaurantlist.restaurants)
        restaurantlist.filterlist = restaurantlist.restaurants
    }
    
    override func viewDidAppear(_ animated: Bool) {
        mapView.setRegion(MKCoordinateRegionMakeWithDistance(
            (locationManager.location?.coordinate)!, 3000, 3000), animated: true)
        print(restaurantlist.filterlist.count)
        mapView.removeAnnotations(mapView.annotations)
        restaurantlist.listRestaurants()
        mapView.addAnnotations(restaurantlist.annotationlist)
        tableView.reloadData()
        print("OK!")
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        mapView.showsUserLocation = true
    }
    
    //在这个方法中给新页面传递参数
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showRestaurant"{
            let controller = segue.destination as! RestaurantViewController
            controller.restaurant = restaurantlist.filterlist[(tableView.indexPathForSelectedRow?.row)!]
            controller.annotation = restaurantlist.annotationlist[(tableView.indexPathForSelectedRow?.row)!]
        }
        else if segue.identifier == "restaurantFilter" || segue.identifier == "randomSelect" {
            let controller = segue.destination as! selectView
            controller.restaurantlist = restaurantlist
            controller.comefrom = segue.identifier
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
