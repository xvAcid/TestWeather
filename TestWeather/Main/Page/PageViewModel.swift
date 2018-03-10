//
//  PageViewModel.swift
//  TestWeather
//
//  Created by xvacid on 3/10/18.
//  Copyright © 2018 WSG4FUN. All rights reserved.
//

import Foundation

class PageViewModel: NSObject {
    var pages = [PageModel]()
    
    override init() {
        super.init()
        
        pages = [PageModel(cityName: "Moscow,RU"),
                 PageModel(cityName: "Sankt-Peterburg,RU"),
                 PageModel(cityName: "Republic of Belarus,BY"),
                 PageModel(cityName: "Pushkino,RU"),
                 PageModel(cityName: "Escuadra,ES"),
                 PageModel(cityName: "Vitacura,CL")]
    }
}
