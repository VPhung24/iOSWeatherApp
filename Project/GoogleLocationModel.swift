//
//  GoogleLocationModel.swift
//  iOSWeatherApp
//
//  Created by Vivian Phung on 7/18/19.
//  Copyright © 2019 Vivian Phung. All rights reserved.
//

import Foundation

struct GoogleLocationModel: Codable {
    struct Place: Codable {
        let description: String
        let id: String
        let text: InfoAboutPlace
        
        enum CodingKeys: String, CodingKey {
            case description
            case id
            case text = "structured_formatting"
        }
    }
    
    struct InfoAboutPlace: Codable {
        let locationName: String
        let locationAddress: String
        
        enum CodingKeys: String, CodingKey {
            case locationName = "main_text"
            case locationAddress = "secondary_text"
        }
    }
    
    let predictions: [Place]
}
