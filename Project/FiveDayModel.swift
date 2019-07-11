//
//  FiveDayModel.swift
//  Project
//
//  Created by Vivian Phung on 7/3/19.
//  Copyright © 2019 Vivian Phung. All rights reserved.
//

import Foundation

struct FiveDayModel: Codable {
    
    struct Weather: Codable {
        let id: Int
        let main: String
        let description: String
        let icon: String
    }
    
    struct Values: Codable {
        let temp_min: Float
        let temp_max: Float
        let temp: Float
        let humidity: Float
    }
    
    struct Clouds: Codable {
        let all: Int
    }
    
    struct Wind: Codable {
        let speed: Float
    }
    
    struct DailyData: Codable {
        let weather: [Weather]
        let main: Values
        let clouds: Clouds
        let wind: Wind
        let dt_txt: String
    }
    
    let list: [DailyData]
       
}
