//
//  TemperaturesView.swift
//  TestWeather
//
//  Created by xvacid on 3/10/18.
//  Copyright © 2018 WSG4FUN. All rights reserved.
//

import UIKit
import RxCocoa
import RxSwift

class TemperaturesView: UIViewController {
    @IBOutlet weak var tableView: UITableView!
    private var viewModel: TemperatureViewModel! = nil
    private let disposeBag = DisposeBag()
    var cityName: String = ""

    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.register(UINib(nibName: "TemperatureTableViewCell", bundle: nil), forCellReuseIdentifier: "TemperatureTableViewCell")
        viewModel = TemperatureViewModel(city: cityName)
        
        viewModel.dayTemperatures.asObservable()
            .observeOn(MainScheduler.instance)
            .subscribe(onNext: { temperatures in
                self.tableView.reloadData()
            }).disposed(by: disposeBag)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}

extension TemperaturesView: UITableViewDelegate {
}

extension TemperaturesView: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.dayTemperatures.value.count == 0 ? 1 : viewModel.dayTemperatures.value.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if viewModel.dayTemperatures.value.count == 0 {
            return UITableViewCell()
        }

        guard let cell = tableView.dequeueReusableCell(withIdentifier: "TemperatureTableViewCell") as? TemperatureTableViewCell else {
            return UITableViewCell()
        }
        cell.fill(data: viewModel.dayTemperatures.value[indexPath.row])
        return cell
    }
}

