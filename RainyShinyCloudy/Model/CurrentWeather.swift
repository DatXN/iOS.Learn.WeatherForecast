//
//  CurrentWeather.swift
//  RainyShinyCloudy
//
//  Created by Nguyễn Xuân Đạt on 2/15/17.
//  Copyright © 2017 Nguyễn Xuân Đạt. All rights reserved.
//

import Foundation
import Alamofire

class CurrentWeather {
    var _cityName: String!
    var _date: String!
    var _weatherType: String!
    var _currentTemp: Double!

    var cityName: String {
        if _cityName == nil {
            _cityName = ""
        }
        return _cityName
    }

    var date: String {
        if _date == nil {
            _date = ""
        }

        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .long
        dateFormatter.timeStyle = .none
        let currentDate = dateFormatter.string(from: Date())
        self._date = "Today, \(currentDate)"
        return _date
    }

    var weatherType: String {
        if _weatherType == nil {
            _weatherType = ""
        }
        return _weatherType
    }

    var currentTemp: Double {
        if _currentTemp == nil {
            _currentTemp = 0.0
        }
        return _currentTemp
    }
    func downloadWeatherData(complete: @escaping DownloadComplete) {
        Alamofire.request(CURRENT_WEATHER_URL).responseJSON { response in
            if let data = response.result.value as? Dictionary<String, AnyObject> {
                if let name = data["name"] as? String {
                    self._cityName = name.capitalized
                }
                if let weather = data["weather"] as? [Dictionary<String, AnyObject>] {

                    if let main = weather[0]["main"] as? String {
                        self._weatherType = main.capitalized
                    }

                }

                if let main = data["main"] as? Dictionary<String, AnyObject> {

                    if let currentTemperature = main["temp"] as? Double {

                        let kelvinToCensius = (currentTemperature - 273.15)

                        self._currentTemp = Double(round(10 * kelvinToCensius / 10))
                    }
                }

            }
            complete()
        }
    }

}
