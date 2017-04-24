//
//  AppExtensions.swift
//  OpenWeatherApp
//
//  Created by Rekha Bisht on 4/23/17.
//  Copyright © 2017 Rekha Bisht. All rights reserved.
//

import UIKit


extension String {
    
    static func convertKelvinToFahrenheit(kelvinTemp:Double) -> String {
        var fahTemp = Double()
        fahTemp = (9/5*(kelvinTemp-273)) + 32
        
        return String(format:"%.0f",fahTemp) + "°F"
    }

}
