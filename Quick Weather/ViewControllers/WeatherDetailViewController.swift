//
//  WeatherDetailViewController.swift
//  Quick Weather
//
//  Created by Deepankar Srivastava on 9/13/17.
//  Copyright © 2017 Deepankar Srivastava. All rights reserved.
//

import UIKit

class WeatherDetailViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    //MARK:- IB-Outlets
    @IBOutlet weak var weatherReportTableView: UITableView!
    
    //MARK:- Global Variables
    var cityName = String()
    
    var forecastArray = [Weather]()

    //MARK:- ViewLifeCycle
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.title = cityName
        self.getWeatherReport()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    func getWeatherReport(){

        HttpConnection.sharedInstance.makeHTTPRequestWith(cityName: cityName) { (error, response) in

            if let responseDictionary = response?["forecast"] as? Dictionary<String, AnyObject> {

                var forecast = Forecast()
                forecast.setWeatherReportWith(response: responseDictionary)
                
                self.forecastArray = forecast.forecastArray
                self.weatherReportTableView.reloadData()
            } else if let errorDict = response?["error"] as? [String:Any] {

                let errorMessage = errorDict["message"] as? String ?? ""
                let alertController =  UIAlertController.init(title: "Oops", message: errorMessage, preferredStyle: .alert)

                let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: { (action) in
                    alertController.dismiss(animated: true, completion: nil)
                })
                alertController.addAction(cancelAction)
                self.present(alertController, animated: true, completion: nil)
            }

        }
    }
    
    //MARK:- UITableView DataSource
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return forecastArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: kWeatherInfoCellIdentifier, for: indexPath) as! WeatherInfoCell
        
        cell.dayNameLabel.text = forecastArray[indexPath.row].day
        cell.dayDescriptionLabel.text = forecastArray[indexPath.row].dayDescription
        cell.highValue.text = forecastArray[indexPath.row].highTemperature
        cell.lowValue.text = forecastArray[indexPath.row].lowTemperature
        
        return cell
    }


}
