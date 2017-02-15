//
//  WeatherVC.swift
//  RainyShinyCloudy
//
//  Created by Nguyễn Xuân Đạt on 2/15/17.
//  Copyright © 2017 Nguyễn Xuân Đạt. All rights reserved.
//

import UIKit
import CoreLocation
import Alamofire

class WeatherVC: UIViewController, UITableViewDelegate, UITableViewDataSource, CLLocationManagerDelegate {

    @IBOutlet weak var lblDate: UILabel!
    @IBOutlet weak var lblCurrentTemp: UILabel!
    @IBOutlet weak var lblLocation: UILabel!
    @IBOutlet weak var imgCurrentWeather: UIImageView!
    @IBOutlet weak var lblCurrentWeatherType: UILabel!
    @IBOutlet weak var tableView: UITableView!
    var currentWeather = CurrentWeather()
    var forecasts = [Forecast]()
    let locationManager = CLLocationManager()
    var currentLocation: CLLocation!

    //

    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self

        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestWhenInUseAuthorization()
        locationManager.startMonitoringSignificantLocationChanges()
        

    }
    
    override func viewDidAppear(_ animated: Bool) {
        // Before view did load
        super.viewDidAppear(animated)
        locationAuthStatus()
            }

    func locationAuthStatus() {
        if CLLocationManager.authorizationStatus() == .authorizedWhenInUse {
            currentLocation = locationManager.location
            Location.sharedInstance.latitude = currentLocation?.coordinate.latitude
            Location.sharedInstance.longitude = currentLocation?.coordinate.longitude
            print(currentLocation.coordinate.latitude, currentLocation.coordinate.longitude)
            //
            
            print(CURRENT_WEATHER_URL)
            print(FORECAST_WEATHER_URL)
            

            //
            currentWeather.downloadWeatherData {
                self.downloadForecastData {
                    self.updateMainUI()
                }
            }
        } else {
            locationManager.requestWhenInUseAuthorization()
            locationAuthStatus()
        }

    }



    func downloadForecastData(completed: @escaping DownloadComplete) {
        Alamofire.request(FORECAST_WEATHER_URL).responseJSON { response in
            let result = response.result

            if let dict = result.value as? Dictionary<String, AnyObject> {

                if let list = dict["list"] as? [Dictionary<String, AnyObject>] {

                    for obj in list {
                        let forecast = Forecast(weatherDict: obj)
                        self.forecasts.append(forecast)
                        print(obj)
                    }
                    self.forecasts.remove(at: 0)
                    self.tableView.reloadData()
                }
            }
            completed()
        }
    }

    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return forecasts.count

    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "weatherCell", for: indexPath) as? WeatherCell {
            let forecast = forecasts[indexPath.row]
            cell.configureCell(forecast: forecast)
            return cell
        }


        return WeatherCell()
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    func updateMainUI() {
        lblDate.text = currentWeather.date
        lblCurrentTemp.text = "\(currentWeather.currentTemp) °C"
        lblCurrentWeatherType.text = currentWeather.weatherType
        lblLocation.text = currentWeather.cityName
        imgCurrentWeather.image = UIImage(named: currentWeather.weatherType)
    }
}

