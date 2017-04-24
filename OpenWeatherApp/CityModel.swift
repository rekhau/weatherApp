//
//  CityModel.swift
//  OpenWeatherApp
//
//  Created by Rekha Bisht on 4/23/17.
//  Copyright © 2017 Rekha Bisht. All rights reserved.
//

import UIKit

struct CityModel {
    
    var cityName:String?
    var minTemp:String?
    var maxTemp:String?
    var currentTemp:String?
    var imageName:String?
    
    init(city:String,min:String,max:String,current:String,image:String) {
        cityName = city
        minTemp = min
        maxTemp = max
        currentTemp = current
        imageName = image
    }
    
    static func convertJSONToObject(jsonObject:[String:AnyObject]) -> CityModel? {
        guard let resultsDict = jsonObject["main"] ,
            let weather = jsonObject["weather"] ,
            let cityName = jsonObject["name"]
            
            else {
                print("Not a valid Dictionary")
                return nil
        }
        
        guard let minTemp = resultsDict["temp_min"] else {
            print("temp_min was not present")
            return nil
        }
        guard let maxTemp = resultsDict["temp_max"] else {
            print("temp_max was not present")
            return nil
        }
        guard let currentTemp = resultsDict["temp"] else {
            print("temp was not present")
            return nil
        }
        
        guard weather.count > 0  else {
            print("Invalid weather Dict ")
            return nil
        }
        
        let iconDict = weather[0] as? [String:AnyObject]
        guard let iconName = iconDict?["icon"] else {
            print("No Image icon")
            return nil
        }
        
        
        let fCurrentTemp = String.convertKelvinToFahrenheit(kelvinTemp: currentTemp as! Double)
        let fMinTemp = String.convertKelvinToFahrenheit(kelvinTemp: minTemp as! Double)
        let fMaxTemp = String.convertKelvinToFahrenheit(kelvinTemp: maxTemp as! Double)
        
        return CityModel(city: cityName as! String, min: fMinTemp, max: fMaxTemp, current: fCurrentTemp,image:iconName as! String)
        
        
        
        
    }
    
}
