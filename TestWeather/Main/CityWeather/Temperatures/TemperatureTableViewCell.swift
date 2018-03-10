//
//  TemperatureTableViewCell.swift
//  TestWeather
//
//  Created by xvacid on 3/10/18.
//  Copyright © 2018 WSG4FUN. All rights reserved.
//

import UIKit

class TemperatureTableViewCell: UITableViewCell {
    @IBOutlet private weak var dateLabel: UILabel!
    @IBOutlet private weak var timeLabel: UILabel!
    @IBOutlet private weak var temperatureLabel: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        dateLabel.text = ""
        timeLabel.text = ""
        temperatureLabel.text = ""
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func fill(data: DayTemperatureInfo) {
        let df = DateFormatter()
        df.dateFormat = "dd MMMM yyyy"
        dateLabel.text = df.string(from: data.fromDate)
        df.dateFormat = "HH:mm"
        timeLabel.text = df.string(from: data.fromDate) + " - " + df.string(from: data.toDate)
        temperatureLabel.text = data.temperature < 0 ? "\(data.temperature)" : "+\(data.temperature)"
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        dateLabel.text = ""
        timeLabel.text = ""
        temperatureLabel.text = ""
    }

}
