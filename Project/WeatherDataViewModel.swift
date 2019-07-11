//
//  WeatherDataViewModel.swift
//  Project
//
//  Created by Vivian Phung on 7/9/19.
//  Copyright © 2019 Vivian Phung. All rights reserved.
//

import Foundation

/// struc holding an array of days
struct WeatherDataViewModel {
    let theSections: [ViewModelSection]
}

/// each day
struct ViewModelSection {
    let sectionTitle: String
    let theData: [FiveDayModel.DailyData]
}
