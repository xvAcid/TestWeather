//
//  CityWeatherView.swift
//  TestWeather
//
//  Created by xvacid on 3/7/18.
//  Copyright © 2018 WSG4FUN. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class CityWeatherView: UIViewController {
    @IBOutlet private weak var cityLabel: UILabel!
    @IBOutlet private weak var temperatureLabel: UILabel!
    private let disposeBag = DisposeBag()
    private var viewModel: CityWeatherViewModel! = nil
    private var temperatureView: TemperaturesView? = nil
    var weatherCity: String = ""
    
//     Проверил, так делать нельзя, так как view на самом деле не переменая с отложенной инициализацией,
//     а не явно извлеченный опционал, и пока view не проиницилизировали, то оно равно nil
//    required init?(coder aDecoder: NSCoder) {
//        super.init(coder: aDecoder)
//        if view != nil {
//            print(view.frame)
//        }
//    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel = CityWeatherViewModel(city: weatherCity)
        viewModel.cityName.asObservable().bind(to: cityLabel.rx.text).disposed(by: disposeBag)
        viewModel.temperature.asObservable().map { $0 < 0 ? "\($0)" : "+\($0)" }.bind(to: temperatureLabel.rx.text).disposed(by: disposeBag)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "TableViewlSegue" {
            temperatureView = segue.destination as? TemperaturesView
            temperatureView!.cityName = weatherCity
        }
    }
}
