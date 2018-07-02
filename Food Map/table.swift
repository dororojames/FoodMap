//
//  table.swift
//  database
//
//  Created by LLF on 2018/6/4.
//  Copyright © 2018 LLF. All rights reserved.
//

import Foundation
import UIKit
import CoreData
class table{
    var App = UIApplication.shared.delegate as! AppDelegate
    var ViewContext: NSManagedObjectContext!
    init(app:AppDelegate){
        self.App = app
        self.ViewContext = App.persistentContainer.viewContext
    }
    func getlist(restlist: inout [Restaurants]){
        deleteData()
        print(NSPersistentContainer.defaultDirectoryURL())
        insertRestaurants()
        do{
            let allRestaurants = try ViewContext.fetch(Restaurants.fetchRequest()) as! [Restaurants]
            
            for Rest in allRestaurants.sorted(by: sorterForRID){
                var priceRange = ["",""]
                var rangeid = 0
                for c in Rest.price_range! {
                    if c >= "0" && c<="9"{
                        priceRange[rangeid].append(c)
                    }
                    else if c == "~"{
                        rangeid=1
                    }
                }
                Rest.price_low = Int(priceRange[0])
                Rest.price_high = Int(priceRange[1])
                restlist.append(Rest)
            }
        }catch{
            print(error)
        }
    }
    func insertRestaurants(){
        let url = Bundle.main.url(forResource:"Restaurants",withExtension:"txt")
        let content = try! String(contentsOf:url!)
        let lineArray = content.components(separatedBy: "\n")
        for line in lineArray{
            let RestInfoArray = line.components(separatedBy: "\t")
            if RestInfoArray[0] != ""
            {
//                print(RestInfoArray)
                let Rest = NSEntityDescription.insertNewObject(forEntityName: "Restaurants", into: ViewContext) as! Restaurants
                Rest.name = RestInfoArray[1]
                Rest.r_ID = NSDecimalNumber(string: RestInfoArray[0])
                Rest.price_range = RestInfoArray[2]
                Rest.latitude = RestInfoArray[3]
                Rest.longitude = RestInfoArray[4]
                Rest.address = RestInfoArray[5]
            }
        }
        App.saveContext()
        let url2 = Bundle.main.url(forResource:"Tags",withExtension:"txt")
        let content2 = try! String(contentsOf:url2!)
        let lineArray2 = content2.components(separatedBy: "\n")
        for line in lineArray2{
            let tagInfoArray = line.components(separatedBy: "\t")
            if tagInfoArray[0] != ""
            {
//                print(tagInfoArray)
                let tag = NSEntityDescription.insertNewObject(forEntityName: "Tags", into: ViewContext) as! Tags
                tag.r_ID = NSDecimalNumber(string: tagInfoArray[0])
                tag.tag = tagInfoArray[1]
                let fetchRequest: NSFetchRequest<Restaurants> = Restaurants.fetchRequest()
                let predicate = NSPredicate(format: "r_ID == \(tag.r_ID ?? 0)")
                fetchRequest.predicate = predicate
                do{
                    let allRest = try ViewContext.fetch(fetchRequest)
                    for Rest in allRest{
                        Rest.addToTag(tag)
                    }
                }catch{
                    print(error)
                }
            }
        }
        let url3 = Bundle.main.url(forResource:"Contacts",withExtension:"txt")
        let content3 = try! String(contentsOf:url3!)
        let lineArray3 = content3.components(separatedBy: "\n")
        for line in lineArray3{
            let ConInfoArray = line.components(separatedBy: "\t")
            if ConInfoArray[0] != ""
            {
//                print(ConInfoArray)
                let Con = NSEntityDescription.insertNewObject(forEntityName: "Contacts", into: ViewContext) as! Contacts
                Con.r_ID = NSDecimalNumber(string: ConInfoArray[0])
                Con.contact = ConInfoArray[1]
                let fetchRequest: NSFetchRequest<Restaurants> = Restaurants.fetchRequest()
                let predicate = NSPredicate(format: "r_ID == \(Con.r_ID ?? 0)")
                fetchRequest.predicate = predicate
                do{
                    let allRest = try ViewContext.fetch(fetchRequest)
                    for Rest in allRest{
                        Rest.addToContact(Con)
                    }
                }catch{
                    print(error)
                }
            }
        }
        let url4 = Bundle.main.url(forResource:"Opentime",withExtension:"txt")
        let content4 = try! String(contentsOf:url4!)
        let lineArray4 = content4.components(separatedBy: "\n")
        for line in lineArray4{
            let OptInfoArray = line.components(separatedBy: "\t")
            if OptInfoArray[0] != ""
            {
//                print(OptInfoArray)
                let Opt = NSEntityDescription.insertNewObject(forEntityName: "Opentime", into: ViewContext) as! Opentime
                Opt.r_ID = NSDecimalNumber(string: OptInfoArray[0])
                Opt.day = OptInfoArray[1]
                Opt.timeslot = OptInfoArray[2]
                let fetchRequest: NSFetchRequest<Restaurants> = Restaurants.fetchRequest()
                let predicate = NSPredicate(format: "r_ID == \(Opt.r_ID ?? 0)")
                fetchRequest.predicate = predicate
                do{
                    let allRest = try ViewContext.fetch(fetchRequest)
                    for Rest in allRest{
                        Rest.addToOpentime(Opt)
                    }
                }catch{
                    print(error)
                }
            }
        }
        App.saveContext()
    }
    func deleteData(){
        do{
            let alldata = try ViewContext.fetch(Restaurants.fetchRequest())
            for rest in alldata as! [Restaurants]{
                ViewContext.delete(rest)
            }
        }catch{
            print(error)
        }
        do{
            let alldata = try ViewContext.fetch(Tags.fetchRequest())
            for tag in alldata as! [Tags]{
                ViewContext.delete(tag)
            }
        }catch{
            print(error)
        }
        do{
            let alldata = try ViewContext.fetch(Contacts.fetchRequest())
            for con in alldata as! [Contacts]{
                ViewContext.delete(con)
            }
        }catch{
            print(error)
        }
        do{
            let alldata = try ViewContext.fetch(Opentime.fetchRequest())
            for opt in alldata as! [Opentime]{
                ViewContext.delete(opt)
            }
        }catch{
            print(error)
        }
        App.saveContext()
    }
}
func sorterForRID(this:Restaurants, that:Restaurants) -> Bool {
    return this.r_ID!.intValue < that.r_ID!.intValue
}
