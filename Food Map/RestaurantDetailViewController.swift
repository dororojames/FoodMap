//
//  RestaurantDetailViewController.swift
//  LifeApp
//
//  Created by Dororo on 2018/6/10.
//  Copyright © 2018年 Student. All rights reserved.
//

import UIKit

class RestaurantDetailCell: UITableViewCell {
    @IBOutlet weak var DetailName: UILabel!
    @IBOutlet weak var DetailContent: UILabel!
}

class RestaurantDetailViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return detaillist.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "restaurantDetailCell", for: indexPath) as! RestaurantDetailCell
//        cell.DetailName?.text = detaillist[indexPath.row].0
        cell.DetailName?.text = ""
        cell.DetailContent?.text = detaillist[indexPath.row].1
        return cell
    }
    
    @IBAction func Back(_ sender: Any) {
        self.presentingViewController!.dismiss(animated: true, completion: nil)
    }
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var navbar: UINavigationBar!
    
    var detaillist = [(String,String)]()
    var restaurant:Restaurants!
    override func viewDidLoad() {
        super.viewDidLoad()
        navbar.topItem?.title = restaurant.name
        detaillist.append(("地址", restaurant.address!))
        detaillist.append(("價位",restaurant.price_range!))
        for c in restaurant.contact as! Set<Contacts>{
            detaillist.append(("聯絡方式",c.contact!))
        }
        for o in restaurant.opentime as! Set<Opentime>{
            detaillist.append(("營業時間",o.day!))
        }
        print(detaillist)
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
