//
//  FiveDayModel.swift
//  iOSWeatherApp
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
        let minTemp: Float
        let maxTemp: Float
        let temp: Float
        let humidity: Float
        
        enum CodingKeys: String, CodingKey {
            case minTemp = "temp_min"
            case maxTemp = "temp_max"
            case temp
            case humidity
        }
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
        let dateText: String
        
        enum CodingKeys: String, CodingKey {
            case main
            case clouds
            case wind
            case weather
            case dateText = "dt_txt"
        }
    }
    
    let list: [DailyData]
}
