//
//  Endpoint.swift
//  iOSWeatherApp
//
//  Created by Vivian Phung on 6/27/19.
//  Copyright © 2019 Vivian Phung. All rights reserved.
//

import Foundation

enum Method: String {
    case GET
    case POST
}

protocol Endpoint {
    var path: String { get }
    var method: Method { get }
    
}

enum WeatherEndpoint: Endpoint {
    case GetWeather, GetHourlyWeather, GetFiveDayWeather, GoogleLocation
    
    var path: String {
        switch self {
        case .GetWeather:
            return "weather"
        case .GetHourlyWeather:
            return "hourly"
        case .GetFiveDayWeather:
            return "forecast"
        case .GoogleLocation:
            return "place/autocomplete/json?"
        }
    }
    
    var method: Method {
        switch self {
        case .GetWeather, .GetHourlyWeather, .GetFiveDayWeather, .GoogleLocation:
            return .GET
        }
    }
}
