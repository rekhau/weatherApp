//
//  AppSettings.swift
//  OpenWeatherApp
//
//  Created by Rekha Bisht on 4/26/17.
//  Copyright © 2017 Rekha Bisht. All rights reserved.
//

import UIKit

struct AppSettings {
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
