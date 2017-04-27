//
//  WeatherSettings.swift
//  OpenWeatherApp
//
//  Created by Rekha Bisht on 4/23/17.
//  Copyright © 2017 Rekha Bisht. All rights reserved.
//

import UIKit

struct WeatherSettings {
    
    static var APIKey : String {
        return "0ca33bade60e05d803afd13697cee031"
    }
    
    static var baseURL : String {
        return "http://api.openweathermap.org/data/2.5/weather?q="
    }
    
    static var imageURL : String {
        return "http://openweathermap.org/img/w/"
    }
}
