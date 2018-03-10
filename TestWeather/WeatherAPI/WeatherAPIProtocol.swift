//
//  WeatherAPIProtocol.swift
//  TestWeather
//
//  Created by xvacid on 3/8/18.
//  Copyright © 2018 WSG4FUN. All rights reserved.
//
import RxSwift
import RxCocoa

protocol WeatherAPIProtocol: class {
    func requestWeather(city: String) -> Observable<WeatherCity>
}
