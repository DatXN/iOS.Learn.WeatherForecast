//
//  Location.swift
//  RainyShinyCloudy
//
//  Created by Nguyễn Xuân Đạt on 2/15/17.
//  Copyright © 2017 Nguyễn Xuân Đạt. All rights reserved.
//

import CoreLocation
class Location {
    static var sharedInstance = Location()
    private init(){
        
    }
    var latitude: Double!
    var longitude: Double!
}

