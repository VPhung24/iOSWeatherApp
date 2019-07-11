//
//  WeatherDataModel.swift
//  Project
//
//  Created by Vivian Phung on 6/27/19.
//  Copyright © 2019 Vivian Phung. All rights reserved.
//

import Foundation

struct WeatherDataModel: Codable {
    
    struct Coordinates: Codable {
        let longitude: Double
        let laditude: Double
        
        enum CodingKeys: String, CodingKey {
            case longitude = "lon"
            case laditude = "lat"
        }
    }
    struct Weather: Codable {
        let id: Int
        let main: String
        let description: String
        let icon: String
    }
    
    let id: Int
    let name: String
    
    let coordinates: Coordinates
    let weather: [Weather]
    
    enum CodingKeys: String, CodingKey {
        case coordinates = "coord"
        case weather
        case id
        case name
    }
}
