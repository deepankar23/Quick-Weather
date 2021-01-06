//
//  HttpConnection.swift
//  Quick Weather
//
//  Created by Deepankar Srivastava on 9/13/17.
//  Copyright © 2017 Deepankar Srivastava. All rights reserved.
//

import UIKit

class HttpConnection: NSObject {

    // MARK:- Singleton instance
    static var sharedInstance: HttpConnection {
        struct Singleton {
            static let instance = HttpConnection()
        }
        return Singleton.instance
    }
    
    // MARK:- Properties
    lazy var urlSession = URLSession.init(configuration: .default)
    
    
    //MARK:- Network Calls
    func makeHTTPRequestWith(cityName city: String , completionBlock completionHandler: @escaping (_ error: Error?, _ response: Dictionary<String,AnyObject>?)->()) {

        // *** OLD Yahoo Weather API- DECOMISSIONED ***
        //        let urlString = "https://query.yahooapis.com/v1/public/yql?q=select%20*%20from%20weather.forecast%20where%20woeid%20in%20(select%20woeid%20from%20geo.places(1)%20where%20text%3D%22\(city)%22)&format=json&env=store%3A%2F%2Fdatatables.org%2Falltableswithkeys"

        //WeatherAPI: https://www.weatherapi.com/my/
        //APIKEY: 93e895ad3b8846f8b9e33843210501

        //TODO: support cities with spaces in the names...
        let apiKey = "93e895ad3b8846f8b9e33843210501"
        let urlString = "https://api.weatherapi.com/v1/forecast.json?key=\(apiKey)&q=\(city)&days=3"

        let url = URL.init(string: urlString)
        
        urlSession.dataTask(with: url!) { (data, responseHeaders, error) in
            
            if let error = error{
                // Handle Error!!!
                completionHandler(error, nil)
                return
            }
            
            if let data = data{
                do{
                    let jsonResponse = try JSONSerialization.jsonObject(with: data, options: .allowFragments) as? Dictionary<String,AnyObject>

                    print(" ==================== \n")
                    print(" jsonResponse --> \(String(describing: jsonResponse))")
                    print(" \n ====================")
                    DispatchQueue.main.async(execute: { 
                        completionHandler(nil, jsonResponse)
                    })
                    
                }catch{
                    print("\n *** Serialization Error!!! *** \n ")
                    
                    DispatchQueue.main.async(execute: { 
                        completionHandler(nil, nil)
                    })
                }
            }
            else{
                completionHandler(nil, nil)
            }
        }.resume()
    }
    
    
    
}
