//
//  PageView.swift
//  TestWeather
//
//  Created by xvacid on 3/7/18.
//  Copyright © 2018 WSG4FUN. All rights reserved.
//

import UIKit

class PageView: UIPageViewController {
    private let viewModel = PageViewModel()
    private var pagesCityWeather = [CityWeatherView]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        dataSource = self
        for page in viewModel.pages {
            let vc = createCityWeatherView(weatherCity: page.cityName)
            pagesCityWeather.append(vc)
        }

        setViewControllers([pagesCityWeather.first!], direction: .forward, animated: true, completion: nil)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    fileprivate func createCityWeatherView(weatherCity: String) -> CityWeatherView {
        let sb = UIStoryboard(name: "Main", bundle: nil)
        let vc = sb.instantiateViewController(withIdentifier: "CityWeatherView") as! CityWeatherView
        vc.weatherCity = weatherCity
        return vc
    }
}

extension PageView: UIPageViewControllerDataSource {
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        guard let viewControllerIndex = pagesCityWeather.index(of: viewController as! CityWeatherView) else { return nil }
        let previousIndex = viewControllerIndex - 1
        guard previousIndex >= 0 else { return pagesCityWeather.last }
        guard pagesCityWeather.count > previousIndex else { return nil }
        return pagesCityWeather[previousIndex]
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        guard let viewControllerIndex = pagesCityWeather.index(of: viewController as! CityWeatherView) else { return nil }
        let nextIndex = viewControllerIndex + 1
        guard nextIndex < pagesCityWeather.count else { return pagesCityWeather.first }
        guard pagesCityWeather.count > nextIndex else { return nil }
        return pagesCityWeather[nextIndex]
    }
    
    func presentationCount(for pageViewController: UIPageViewController) -> Int {
        return viewModel.pages.count
    }

    func presentationIndex(for pageViewController: UIPageViewController) -> Int {
        return 0
    }
}
