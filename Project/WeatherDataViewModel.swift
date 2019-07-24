//
//  WeatherDataViewModel.swift
//  iOSWeatherApp
//
//  Created by Vivian Phung on 7/9/19.
//  Copyright © 2019 Vivian Phung. All rights reserved.
//

import Foundation

/// Each section is a day
struct WeatherDataViewModel {
    let theSections: [ViewModelSection]
}

/// sections have a title of the date and theData is an array of weather data to be passed to rows
struct ViewModelSection {
    let sectionTitle: String
    let theData: [FiveDayModel.DailyData]
}
