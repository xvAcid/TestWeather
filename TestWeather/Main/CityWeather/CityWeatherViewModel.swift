//
//  CityWeatherViewModel.swift
//  TestWeather
//
//  Created by xvacid on 3/10/18.
//  Copyright © 2018 WSG4FUN. All rights reserved.
//
import Foundation
import RxCocoa
import RxSwift

class CityWeatherViewModel: NSObject {
    private let weatherService: WeatherAPI = WeatherXMLService()
    let cityName = Variable<String>("Loading...")
    let temperature = Variable<Int>(0)

    init(city: String) {
        super.init()
        
        let _ = weatherService.requestWeather(city: city).subscribe(onNext: { weather in
            self.cityName.value = weather.city
            self.temperature.value = weather.temperature
        }, onError: { error in
            self.cityName.value = "Loading error"
        })
    }
}
