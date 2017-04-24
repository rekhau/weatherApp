//
//  AppSettings.swift
//  OpenWeatherApp
//
//  Created by Rekha Bisht on 4/23/17.
//  Copyright © 2017 Rekha Bisht. All rights reserved.
//

import UIKit

struct AppSettings {
    
    static var APIKey : String {
        return "0ca33bade60e05d803afd13697cee031"
    }
    
    static var baseURL : String {
        return "http://api.openweathermap.org/data/2.5/weather?q="
    }
    
    static var imageURL : String {
        return "http://openweathermap.org/img/w/"
    }
    
    static var lastCitySearched : String {
        get {
            let defaults = UserDefaults.standard
            let city = defaults.object(forKey: "lastCity") as? String
            return city ?? String()
        }
        
        set {
            let defaults = UserDefaults.standard
            defaults.set(newValue, forKey: "lastCity")
        }
        
        
    }
    
}
