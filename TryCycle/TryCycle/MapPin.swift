//
//  MapPin.swift
//  TryCycle
//
//  Created by Heather Connery on 2015-11-16.
//  Copyright © 2015 HConnery. All rights reserved.
//

import UIKit
import MapKit

final class MapPin: NSObject, MKAnnotation {
    
    var coordinate: CLLocationCoordinate2D
    var title: String?
    var subTitle: String?
    
    init(coordinate: CLLocationCoordinate2D, title: String, subTitle:String) {
        self.coordinate = coordinate
        self.title = title
        self.subTitle = subTitle
    }

}
