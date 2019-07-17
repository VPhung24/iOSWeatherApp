//
//  FiveDayViewController.swift
//  Project
//
//  Created by Vivian Phung on 7/3/19.
//  Copyright © 2019 Vivian Phung. All rights reserved.
//

import UIKit
import Foundation

class FiveDayViewController: UIViewController {
    private var data: FiveDayModel? = nil
    private var images: [String: UIImage] = [:]
    private var sectionModel: WeatherDataViewModel? = nil
    
    private lazy var myTableView: UITableView = {
        let tableView = UITableView(frame: .zero)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.register(MyRowWithDate.self, forCellReuseIdentifier: MyRowWithDate.reuseIdentifier)
        return tableView
    }()
    
    private lazy var myButton: UIBarButtonItem = {
        let button = UIBarButtonItem(title: "City", style: .plain, target: self, action: #selector(changethisCity))
        return button
    }()
    
    @objc func changethisCity() {
        let changeVC = ChangeCityViewController()
        changeVC.delegate = self
        let navVC = UINavigationController(rootViewController: changeVC)
        self.present(navVC, animated: true)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(myTableView)
        
        NSLayoutConstraint.activate([
            myTableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            myTableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            myTableView.topAnchor.constraint(equalTo: view.topAnchor),
            myTableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
            ])
        
        if let city = UserDefaults.standard.string(forKey: "city") {
            apiRequest(city: city)
            print("default city is \(city)")
            title = "\(city) 5 Day Forecast"
        } else {
            UserDefaults.standard.set("San Francisco", forKey: "city")
            apiRequest(city: "San Francisco")
            print("city is SF")
            title = "San Francisco 5 Day Forecast"
        }
        
        self.navigationItem.leftBarButtonItem = myButton
    }
    
    func apiRequest(city: String) {
        if let myCity = UserDefaults.standard.string(forKey: "city") {
            print("currently, user default city is " + myCity)
            
            if myCity != city {
                UserDefaults.standard.set(city, forKey: "city")
                print("changed, user default city is " + city)
                title = "\(city) 5 Day Forecast"
            }
        }
        APIManager.shared.getFiveDayWeather(forCity: city) { [weak self] (response, error) in
            guard error == nil, let response = response else {
                print("apiRequest error: ", error)
                return
            }
            
            self?.data = response
            
            self?.sectionModel = self?.conformToWeatherViewModel(response: response)
            
            DispatchQueue.main.async {
                self?.myTableView.reloadData()
            }
            self?.downloadImages()
        }
    }
    
    func conformToWeatherViewModel(response: FiveDayModel?) -> WeatherDataViewModel? {
        guard let apiReponse = response else { return nil }
        var setOfDates: Set<String> = []
        var array: [FiveDayModel.DailyData] = []
        var sections: [ViewModelSection] = []
        var date: String = ""
        var oldDate: String = ""
        
        for info in apiReponse.list {
            
            date = (info.dateText).components(separatedBy: " ").first ?? ""
            if setOfDates.isEmpty {
                setOfDates.insert(date)
                oldDate = date
            }
            
            if setOfDates.contains(date) {
                array.append(info)
            } else {
                sections.append(ViewModelSection(sectionTitle: myDateFormatter(dayDate: oldDate), theData: array))
                array = [info]
                setOfDates.insert(date)
                oldDate = date
            }
            
        }
        sections.append(ViewModelSection(sectionTitle: myDateFormatter(dayDate: date), theData: array))
        return WeatherDataViewModel(theSections: sections)
    }
    
    func downloadImages() {
        let baseURL: String = "https://openweathermap.org/img/wn/"
        let suffix: String = "@2x.png"
        
        if let data = data {
            for day in data.list {
                guard let imageName = day.weather.first?.icon else { return }
                
                let imageURL = baseURL + imageName + suffix
                let url = URL(string: imageURL)
                
                URLSession.shared.dataTask(with: url!) { [weak self] (data, response, error) in
                    guard error == nil, let data = data else {
                        print(error)
                        return
                    }
                    
                    DispatchQueue.main.async {
                        self?.images[imageName] = UIImage(data: data)
                    }
                    }.resume()
            }
        }
        
        DispatchQueue.main.async {
            self.myTableView.reloadData()
        }
    }
    
    /// formats dates like 2019-07-09 to
    func myDateFormatter(dayDate: String) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        let theDate = dateFormatter.date(from: dayDate)
        dateFormatter.dateFormat = "MMM dd, yyy"
        return dateFormatter.string(from: theDate!)
    }
}

extension FiveDayViewController: UITableViewDelegate {
    
}

extension FiveDayViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: MyRowWithDate.reuseIdentifier) as! MyRowWithDate
        
        let dailyData = sectionModel?.theSections[indexPath.section].theData[indexPath.row]
        if let iconName = dailyData?.weather.first?.icon, let image = images[iconName] {
            cell.setImage(newImage: image)
        }
        if let text = dailyData?.weather.first?.description {
            cell.setCellText(newText: text, date: (dailyData?.dateText)?.components(separatedBy: " ").last)
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return sectionModel?.theSections[section].theData.count ?? 0
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return sectionModel?.theSections.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return sectionModel?.theSections[section].sectionTitle
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let fullVC = FullViewController()
        if let data = sectionModel?.theSections[indexPath.section].theData[indexPath.row] {
            fullVC.row = data
        }
        if let cell = tableView.cellForRow(at: indexPath) as? MyRowWithDate {
            fullVC.image = cell.myPhoto.image
            fullVC.time = cell.myDateText.text
            fullVC.weather = cell.myWeatherText.text
        }
        fullVC.myDate = sectionModel?.theSections[indexPath.section].sectionTitle
        self.navigationController?.pushViewController(fullVC, animated: true)
        tableView.deselectRow(at: indexPath, animated: true)
    }
}

extension FiveDayViewController: ChangeCityDelegate {
    func changeCity(city: String) {
        apiRequest(city: city)
    }
}
