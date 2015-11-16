//
//  ViewController.swift
//  TryCycle
//
//  Created by Heather Connery on 2015-11-16.
//  Copyright © 2015 HConnery. All rights reserved.
//

import UIKit
import MapKit


class ViewController: UIViewController, CLLocationManagerDelegate, MKMapViewDelegate {
    
    var endpoint = NSURL(string: "http://www.bikesharetoronto.com/stations/json")
    let locationManager = CLLocationManager()
    
    @IBOutlet weak var mapView: MKMapView!
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.locationManager.delegate = self
        self.mapView.delegate = self
        self.locationManager.startUpdatingLocation()
        self.locationManager.requestWhenInUseAuthorization()
        
        let data = NSData(contentsOfURL: endpoint!)
        //print(data)
        var json: NSDictionary?
        do {
            json = try NSJSONSerialization.JSONObjectWithData(data!, options: NSJSONReadingOptions.MutableContainers) as? NSDictionary
            //print(json)
            // above, the try is for the Serialization - then we say treat whatever we get from that as an NSDictionary - but it isn't unwrappped yet
            // ...so we if let the json object - here we don't have to specify as? anything or use ! b/c we already associated the object with the type NSDictionary above. Here we say if it is valid (implicitly as an NSDictionary) then continue
            if let jsonData = json {
                let station = Station(json: jsonData)
                
                for pins in station.mapPins {
                    // 3 ways to handle this below - maybe okay to use (3) b/c we do many checks before this stage, reasonalbly assured they exist as correct type
                    //1 guard let - this is okay because if it fails it will continue execution of the loop
                    guard let pin = pins as? MapPin else {return}
                    mapView.addAnnotation(pin)
                    
                    //2) if let
//                    if let pin = pins as? MapPin {
//                        mapView.addAnnotation(pin)
//                    }
                    
                    //3) force unwrapping - this gives the same result as using (pins as! MapPin)
                   //mapView.addAnnotation((pins as? MapPin)!)
                    
                }
            }
           
        } catch let error {
            print(error)
        }
        
        //var station = Station(json: json)
        
//        if let bikeShareStations = json["stationBeanList"] as? NSArray {
//            
//            var bikeShareData = bikeShareStations[0] as? NSDictionary
//            
//            if let bikeShare = bikeShareData {
//                print(bikeShare["availableBikes"]!)
//                print(bikeShare["availableDocks"]!)
//                print(bikeShare["latitude"]!)
//                print(bikeShare["longitude"]!)
//                print(bikeShare["stationName"]!)
//            } else {
//                print("Error pulling data from bikeShareData")
//            }
//        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

