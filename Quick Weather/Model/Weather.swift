
//
//  Weather.swift
//  Quick Weather
//
//  Created by Deepankar Srivastava on 9/13/17.
//  Copyright © 2017 Deepankar Srivastava. All rights reserved.
//

import Foundation


struct Weather {
    
    var day: String?
    var dayDescription: String?
    var highTemperature: String?
    var lowTemperature: String?
    
}

struct Forecast {
    
    var forecastArray = [Weather]()
    
    mutating func setWeatherReportWith(response: Dictionary<String, Dictionary<String,AnyObject>>){
        
        print("\n *** response *** \n \(response) \n ")
 
        let responseArray = response["channel"]?["item"]?["forecast"] as? [Dictionary<String,Any>] ?? []
        
        for object in responseArray{
            
            var weather = Weather()
            weather.day = object["day"] as? String
            weather.dayDescription = object["text"] as? String
            weather.highTemperature = object["high"] as? String
            weather.lowTemperature = object["low"] as? String
            forecastArray.append(weather)
        }
        
    }
}

