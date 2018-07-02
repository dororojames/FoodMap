//
//  selectView.swift
//  LifeApp
//
//  Created by Dororo on 2018/6/1.
//  Copyright © 2018年 Student. All rights reserved.
//

import Foundation
import UIKit
import CoreLocation

class selectView: UIViewController, UITextFieldDelegate, CLLocationManagerDelegate, UIPickerViewDelegate, UIPickerViewDataSource {
    @IBOutlet weak var pickView: UIPickerView!
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return restaurantlist.alltags.count
    }
    func pickerView(_ pickerView: UIPickerView,
                    titleForRow row: Int,
                    forComponent component: Int) -> String? {
        return restaurantlist.alltags[row]
    }
    func pickerView(_ pickerView: UIPickerView,
                    didSelectRow row: Int, inComponent component: Int) {
        picktag = restaurantlist.alltags[row]
    }
    
    @IBAction func Back(_ sender: Any) {
        self.restaurantlist.filterlist = self.restaurantlist.restaurants
        self.restaurantlist.listRestaurants()
    }
    
    @IBOutlet weak var price_low: UITextField!
    @IBOutlet weak var price_high: UITextField!
    @IBOutlet weak var distance_low: UITextField!
    @IBOutlet weak var distance_high: UITextField!
    var picktag: String! = ""
    @IBAction func search(_ sender: Any) {
        print(picktag,price_low.text!,price_high.text!,distance_low.text!,distance_high.text!)
        if price_low.text! == "" || price_high.text!  == "" || distance_low.text! == "" || distance_high.text! == "" || restaurantlist.filter(selecttag: picktag, price_low: Int(price_low.text!)!, price_high: Int(price_high.text!)!, distance_low: Double(distance_low.text!)!, distance_high: Double(distance_high.text!)!, locaton: locationManager.location!) == false{
            let alert = UIAlertController(title: "錯誤的篩選", message: "找不找符合的餐廳\n請重新輸入", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "好", style: .default, handler: nil))
            self.present(alert, animated: true, completion: nil)
        }
        else{
            print("filter OK")
            if comefrom == "restaurantFilter"{
                performSegue(withIdentifier: "refreshList", sender: self)
            }
            else if comefrom == "randomSelect"{
                performSegue(withIdentifier: "showRandom", sender: self)
            }
        }
    }
    
    var restaurantlist: RestaurantList!
    var comefrom: String!
    let locationManager = CLLocationManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        NotificationCenter.default.addObserver(self, selector: #selector(self.keyboardWillShow), name: NSNotification.Name.UIKeyboardWillShow, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(self.keyboardWillHide), name: NSNotification.Name.UIKeyboardWillHide, object: nil)
        price_low.delegate = self
        price_high.delegate = self
        distance_low.delegate = self
        distance_high.delegate = self
        locationManager.delegate = self
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()
        picktag = restaurantlist.alltags[0]
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField == price_low {
            price_high.becomeFirstResponder()
        }
        else if textField == price_high {
            distance_low.becomeFirstResponder()
        }
        else if textField == distance_low {
            distance_high.becomeFirstResponder()
        }
        else{
            price_low.resignFirstResponder()
        }
        return true
    }
    
    @objc func keyboardWillShow(notification: NSNotification) {
        if let keyboardSize = (notification.userInfo?[UIKeyboardFrameBeginUserInfoKey] as? NSValue)?.cgRectValue {
            if self.view.frame.origin.y == 0{
                self.view.frame.origin.y -= keyboardSize.height
            }
        }
    }
    
    @objc func keyboardWillHide(notification: NSNotification) {
        if let keyboardSize = (notification.userInfo?[UIKeyboardFrameBeginUserInfoKey] as? NSValue)?.cgRectValue {
            if self.view.frame.origin.y != 0{
                self.view.frame.origin.y += keyboardSize.height
            }
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "refreshList" || segue.identifier == "cancelFilter"{
            let controller = segue.destination as! MapViewController
            controller.restaurantlist.filterlist = self.restaurantlist.filterlist
            controller.restaurantlist.listRestaurants()
        }
        else if segue.identifier == "showRandom" {
            let controller = segue.destination as! RestaurantViewController
            let random = Int(arc4random_uniform(UInt32(restaurantlist.filterlist.count)))
            controller.restaurant = restaurantlist.filterlist[random]
            controller.annotation = restaurantlist.annotationlist[random]
            self.restaurantlist.filterlist = self.restaurantlist.restaurants
            self.restaurantlist.listRestaurants()
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
