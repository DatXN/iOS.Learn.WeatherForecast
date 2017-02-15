//
//  Constants.swift
//  RainyShinyCloudy
//
//  Created by Nguyễn Xuân Đạt on 2/15/17.
//  Copyright © 2017 Nguyễn Xuân Đạt. All rights reserved.
//

import Foundation
let BASE_URL = "http://api.openweathermap.org/data/2.5/weather?"
let LATTITUDE = "lat="
let LONGITUDE = "&lon="
let APP_ID = "&appid="
let APP_KEY = "c95a9c0eccfaf004b00e7c09cee8398c"

let CURRENT_WEATHER_URL = "\(BASE_URL)\(LATTITUDE)\(Location.sharedInstance.latitude!)\(LONGITUDE)\(Location.sharedInstance.longitude!)\(APP_ID)\(APP_KEY)"

let FORECAST_BASE_URL = "http://api.openweathermap.org/data/2.5/forecast/daily?"

let DAYS="&cnt=6"
let FORECAST_WEATHER_URL = "\(FORECAST_BASE_URL)\(LATTITUDE)\(Location.sharedInstance.latitude!)\(LONGITUDE)\(Location.sharedInstance.longitude!)\(DAYS)\(APP_ID)\(APP_KEY)"

typealias DownloadComplete = () -> ()
