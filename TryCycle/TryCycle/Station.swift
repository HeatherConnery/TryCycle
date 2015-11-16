//
//  Station.swift
//  TryCycle
//
//  Created by Heather Connery on 2015-11-16.
//  Copyright © 2015 HConnery. All rights reserved.
//

import Foundation
import MapKit

struct Station {
    
    var mapPins: NSMutableArray = []
    
    //initializer
    init(json:NSDictionary) {
        
        if let bikeShareStations = json["stationBeanList"] as? NSArray {
            let bikeShareDepots = bikeShareStations
            for var i = 0; i < bikeShareDepots.count; i++ {
                
                var availableBikes:Int?
                var availableDocks:Int?
                var latitude:Float?
                var longitude:Float?
                var stationName:String?
                
                let bikeShareData = bikeShareDepots[i] as? NSDictionary
                if let bikeShare = bikeShareData {
                    if let bike = bikeShare["availableBikes"] as? Int {
                        availableBikes = bike as Int
                        //print(availableBikes!)
                    }
                    if let dock = bikeShare["availableDocks"] as? Int {
                        availableDocks = dock as Int
                        //print(availableDocks!)
                    }
                    if let lat = bikeShare["latitude"] as? Float {
                        latitude = lat as Float
                        //print(latitude!)
                    }
                    if let long = bikeShare["longitude"] as? Float {
                        longitude = long
                        //print(longitude!)
                    }
                    if let station = bikeShare["stationName"] as? String {
                        stationName = station
                        //print(stationName!)
                    }
                    //create an instance of our MapPin class
                    let pin = MapPin(coordinate: CLLocationCoordinate2D(latitude: CLLocationDegrees(latitude!),longitude: CLLocationDegrees(longitude!)), title: stationName!, subTitle: "Bikes Available \(availableBikes!)")
                    mapPins.addObject(pin)
                }
            }
        }
    }
    
}
