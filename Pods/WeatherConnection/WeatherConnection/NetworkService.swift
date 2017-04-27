//
//  NetworkService.swift
//  OpenWeatherApp
//
//  Created by Rekha Bisht on 4/23/17.
//  Copyright © 2017 Rekha Bisht. All rights reserved.
//

import UIKit

public class NetworkService {
    public typealias dataHandler = (Data?,NSError?) -> Void
    public typealias completionHandler = (CityModel?,NSError?) -> Void
    
    
    fileprivate struct Locals {
        static var manager: URLSession?
    }
    
    fileprivate class var manager: URLSession {
        get {
            if Locals.manager == nil {
                let configuration = URLSessionConfiguration.default
                configuration.allowsCellularAccess = true
                let _manager = URLSession(configuration:configuration )
                Locals.manager = _manager
                
            }
            return Locals.manager!
        }
    }
    
    
    //Method to download the weather data
    public class func downloadData(forCity: String , handler:@escaping completionHandler) -> Void {
        let urlString = WeatherSettings.baseURL + forCity + "&APPID=" + WeatherSettings.APIKey
        let escapedURL = urlString.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)
        let request = URLRequest(url: URL(string: escapedURL!)!)
        
        let task:URLSessionDataTask = manager.dataTask(with: request) { (data, response, error) in
            guard error == nil else {
                print("There was error in calling request \(String(describing: error))")
                return
            }
            guard let responseData = data else {
                print("There was no response received)")
                return
            }
            
            //Convert json data into model  data
            do {
                let jsonData = try JSONSerialization.jsonObject(with: responseData, options: .allowFragments)
                
                guard let responseDict = jsonData as? [String:AnyObject] else {
                    print("Not a Dictionary")
                    return
                }
                
                let cityDetails = CityModel.convertJSONToObject(jsonObject: responseDict )
                handler(cityDetails,error as NSError?)
                
            }
            catch  {
                print("Error calling the service \(error)")
            }
            
            
            
        }
        
        task.resume()
        
        
    }
    
    
    
    public class func downloadWeatherImage(forWeatherType: String,handler:@escaping dataHandler) -> Void {
        let urlString = WeatherSettings.imageURL + forWeatherType + ".png"
        let url = URL(string: urlString)
        
        var request = URLRequest(url: url!, cachePolicy: .reloadIgnoringLocalAndRemoteCacheData, timeoutInterval: 60)
        request.httpMethod = "GET"
        
        let task:URLSessionDataTask = manager.dataTask(with: request, completionHandler: {
            (data,response,error) in
            if (error == nil) {
                handler(data,error as NSError?)
            }
        })
        task.resume()
    }
    
    
}
