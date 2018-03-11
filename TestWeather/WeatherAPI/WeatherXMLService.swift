//
//  WeatherXMLService.swift
//  TestWeather
//
//  Created by xvacid on 3/8/18.
//  Copyright © 2018 WSG4FUN. All rights reserved.
//
import Foundation
import RxSwift
import RxCocoa
import AFNetworking
import SWXMLHash

class WeatherXMLService: NSObject {
    private let urlTemperatures: String = "https://api.openweathermap.org/data/2.5/forecast"
    private let urlCurrent: String = "https://api.openweathermap.org/data/2.5/weather"
    private let api: String = "368ec6f7642003efc267288296cc0d7e"

    fileprivate func parceCurrentWeather(node: XMLIndexer) -> WeatherCity {
        do {
            let cityNode        = try node.byKey("current").byKey("city").element?.attribute(by: "name")
            let temperatureNode = try node.byKey("current").byKey("temperature").element?.attribute(by: "value")
            
            if cityNode != nil && temperatureNode != nil {
                let df          = DateFormatter()
                df.dateFormat   = "yyyy-MM-dd'T'HH:mm:ss"
                let value       = Double(temperatureNode!.text)
                let weatherCity = WeatherCity(city: cityNode!.text, temperature: Int(value!))
                return weatherCity
            }
        } catch {
        }
        
        return WeatherCity()
    }
    
    fileprivate func parceDayTemperatures(node: XMLIndexer) -> [DayTemperatureInfo] {
        do {
            let forecastNode    = try node.byKey("weatherdata").byKey("forecast")
            let df              = DateFormatter()
            var temperatures    = [DayTemperatureInfo]()
            df.dateFormat       = "yyyy-MM-dd'T'HH:mm:ss"
            
            for child in forecastNode.children {
                var temperature     = DayTemperatureInfo()
                let fromDateNode    = child.element?.attribute(by: "from")
                let toDateNode      = child.element?.attribute(by: "to")
                let temperatureNode = try child.byKey("temperature").element?.attribute(by: "value")
                
                if fromDateNode != nil && toDateNode != nil {
                    temperature.fromDate    = df.date(from: fromDateNode!.text)!
                    temperature.toDate      = df.date(from: toDateNode!.text)!
                }
                
                if temperatureNode != nil {
                    let value = Double(temperatureNode!.text)
                    temperature.temperature = Int(value!)
                }
                
                temperatures.append(temperature)
            }
            return temperatures
        } catch {
        }
        
        return []
    }
}

// - MARK: WeatherAPIProtocol
extension WeatherXMLService: WeatherAPI {
    func requestWeather(city: String) -> Observable<WeatherCity> {
        return Observable.create({ [weak self] observer -> Disposable in
            let disposable = Disposables.create()
            guard let `self` = self else { return disposable }
            
            let manager                 = AFHTTPSessionManager()
            manager.responseSerializer  = AFHTTPResponseSerializer()
            let params = ["q": city,
                          "appid": self.api,
                          "mode": "xml",
                          "units": "metric"]
            
            manager.get(self.urlCurrent, parameters: params, progress: nil, success: { responce, objects in
                let node    = SWXMLHash.parse(objects as! Data)
                let weather = self.parceCurrentWeather(node: node)
                observer.onNext(weather)
                observer.onCompleted()
            }, failure: { responce, error in
                observer.onError(error)
            })
            
            return disposable
        })
    }
    
    func requestWeatherByDays(city: String) -> Observable<[DayTemperatureInfo]> {
        return Observable.create({ [weak self] observer -> Disposable in
            let disposable = Disposables.create()
            guard let `self` = self else { return disposable }
            
            let manager                 = AFHTTPSessionManager()
            manager.responseSerializer  = AFHTTPResponseSerializer()
            let params = ["q": city,
                          "appid": self.api,
                          "mode": "xml",
                          "units": "metric"]
            
            manager.get(self.urlTemperatures, parameters: params, progress: nil, success: { responce, objects in
                let node            = SWXMLHash.parse(objects as! Data)
                let temperatures    = self.parceDayTemperatures(node: node)
                observer.onNext(temperatures)
                observer.onCompleted()
            }, failure: { responce, error in
                observer.onError(error)
            })
            
            return disposable
        })
    }
}
