//
//  APIManager.swift
//  iOSWeatherApp
//
//  Created by Vivian Phung on 6/27/19.
//  Copyright © 2019 Vivian Phung. All rights reserved.
//

import Foundation

class APIManager {
    static let shared = APIManager()
    
    // force using shared instance
    
    private init() {}
    
    private let apiKey = "99d96ae777f1b21335989a1cc46ab43a"
    private let baseURL = "https://api.openweathermap.org/data/2.5/"
    
    private let googleURL = "https://maps.googleapis.com/maps/api/"
    private let googleKey = "AIzaSyAxA7yscwR-OWIV-n2A2OMJGYK3D2J4SI0"
    // API calls
    
    func getFiveDayWeather(forCity city: String, completionHandler: @escaping (FiveDayModel?, Error?) -> Void) {
        let parameters: [String: Any] = ["q": city, "units": "imperial", "appid": apiKey]
        let urlRequest = networkRequest(baseURL: baseURL, endpoint: WeatherEndpoint.GetFiveDayWeather, parameters: parameters)
        networkTask(request: urlRequest) { (response: FiveDayModel?, error) in
            completionHandler(response, error)
            
        }
    }
    
    func googleAuto(forString input: String, completionHandler: @escaping (GoogleLocationModel?, Error?) -> Void) {
        let parameters: [String: Any] = ["input": input, "types": "(cities)", "key": googleKey]
        let urlRequest = networkRequest(baseURL: googleURL, endpoint: WeatherEndpoint.GoogleLocation, parameters: parameters)
        networkTask(request: urlRequest) { (response: GoogleLocationModel?, error) in
            completionHandler(response, error)
        }
    }
    
    // Networking
    
    func networkRequest(baseURL: String, endpoint: Endpoint, parameters: [String: Any]? = nil, headers: [String: String]? = nil) -> URLRequest {
        var components = URLComponents(string: baseURL + endpoint.path)!
        guard let parameters = parameters else {
            return requestBuilder(url: components.url!, endpoint: endpoint, headers: headers)
        }
        components.queryItems = parameters.map {
            URLQueryItem(name: $0, value: "\($1)")
        }
        
        return requestBuilder(url: components.url!, endpoint: endpoint, headers: headers)
    }
    
    func requestBuilder(url: URL, endpoint: Endpoint, headers: [String: String]? = nil) -> URLRequest {
        let request = NSMutableURLRequest(url: url)
        request.httpMethod = endpoint.method.rawValue
        headers?.forEach {
            request.addValue($1, forHTTPHeaderField: $0)
        }
        return request as URLRequest
    }
    
    func networkTask<T: Codable>(request: URLRequest, completionHandler: @escaping (T?, Error?) -> Void) {
        let session: URLSession = URLSession.shared
        
        let task = session.dataTask(with: request) { data, response, error in
            guard let responseData = data, error == nil else {
                completionHandler(nil, error)
                return
            }
            
            let decoder = JSONDecoder()
            do {
                let jsonData: T = try decoder.decode(T.self, from: responseData)
                completionHandler(jsonData, nil)
            } catch let error { // catches decoding error from the try
                completionHandler(nil, error)
            }
        }
        task.resume()
    }
}
