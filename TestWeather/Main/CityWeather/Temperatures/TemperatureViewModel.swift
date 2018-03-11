//
//  TemperatureViewModel.swift
//  TestWeather
//
//  Created by xvacid on 3/10/18.
//  Copyright © 2018 WSG4FUN. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa

class TemperatureViewModel: NSObject {
    private let weatherService: WeatherAPI = WeatherXMLService()
    private let disposeBag = DisposeBag()
    public var dayTemperatures = Variable<[DayTemperatureInfo]>([])
    
    init(city: String) {
        super.init()
        let _ = weatherService.requestWeatherByDays(city: city).subscribe(onNext: { temperatures in
            self.dayTemperatures.value = temperatures
        }, onError: { error in
            self.dayTemperatures.value = []
        }).disposed(by: disposeBag)
    }
}
