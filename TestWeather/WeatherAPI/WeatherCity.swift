//
//  WeatherCity.swift
//  TestWeather
//
//  Created by xvacid on 3/8/18.
//  Copyright © 2018 WSG4FUN. All rights reserved.
//
import Foundation

struct DayTemperatureInfo {
    var fromDate: Date = Date()
    var toDate: Date = Date()
    var temperature: Int = 0
}

struct WeatherCity {
    var city: String = ""
    var temperature: Int = 0
}
