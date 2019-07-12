//
//  FullViewController.swift
//  Project
//
//  Created by Vivian Phung on 7/10/19.
//  Copyright © 2019 Vivian Phung. All rights reserved.
//

import Foundation
import UIKit

class FullViewController: BaseViewController {
    lazy var dateTextLabel: UILabel = nonWrappingLabel(fontSize: 20)
    lazy var hourTextLabel: UILabel = nonWrappingLabel(fontSize: 50)
    lazy var weatherTextLabel: UILabel = nonWrappingLabel(fontSize: 55)
    lazy var maxTempTextLabel: UILabel = wrappingLabel(fontSize: 20)
    lazy var tempTextLabel: UILabel = wrappingLabel(fontSize: 20)
    lazy var minTempTempTextLabel: UILabel = wrappingLabel(fontSize: 20)
    lazy var cloudTextLabel: UILabel = wrappingLabel(fontSize: 20)
    lazy var windTextLabel: UILabel = wrappingLabel(fontSize: 20)
    lazy var stackView: UIStackView = newStackView(axis: .horizontal)
    lazy var cloudAndWindStackView: UIStackView = newStackView(axis: .horizontal)
    lazy var allStackView: UIStackView = newStackView(axis: .vertical)
    lazy var fullImageView: UIImageView = newImageView()
    
    var image: UIImage? = nil
    var time: String? = nil
    var weather: String? = nil
    var myDate: String? = nil
    var row: FiveDayModel.DailyData? = nil
    var verticalSpacerConstant: CGFloat = 10
    var horizontalSpacerConstant: CGFloat = 10
    var ratioConstraint: NSLayoutConstraint?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.white
        title = "Hour Forecast"
        view.addSubview(fullImageView)
        view.addSubview(allStackView)
        
        NSLayoutConstraint.activate([
            fullImageView.topAnchor.constraint(equalTo: view.topAnchor, constant: verticalSpacerConstant),
            fullImageView.bottomAnchor.constraint(equalTo: view.centerYAnchor, constant: -verticalSpacerConstant * 4),
            fullImageView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: horizontalSpacerConstant),
            fullImageView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -horizontalSpacerConstant),
            
            allStackView.topAnchor.constraint(equalTo: fullImageView.bottomAnchor, constant: verticalSpacerConstant),
            allStackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: horizontalSpacerConstant),
            allStackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -horizontalSpacerConstant),
            allStackView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -horizontalSpacerConstant * 4),
            ])
        
        if let theDate = myDate {
            setText(label: dateTextLabel, text: theDate)
        }
        
        if let theImage = image {
            setImage(myView: fullImageView, image: theImage)
        }
        
        if let theTime = time {
            setText(label: hourTextLabel, text: theTime)
            title = theTime + " forecast"
        }
        
        if let theWeather = weather {
            setText(label: weatherTextLabel, text: theWeather)
        }
        
        if let weatherData = row {
            setText(label: minTempTempTextLabel, text: "Min Temp: \n" + String(format: "%.2f", weatherData.main.minTemp) + "\u{00B0}")
            setText(label: tempTextLabel, text: "Temp: \n" + String(format: "%.2f", weatherData.main.temp) + "\u{00B0}")
            setText(label: maxTempTextLabel, text: "Max Temp: \n" + String(format: "%.2f", weatherData.main.maxTemp) + "\u{00B0}")
            setText(label: cloudTextLabel, text: "Cloudiness: \n" + String(weatherData.clouds.all) + "%")
            setText(label: windTextLabel, text: "Wind Speed: \n" + String(weatherData.wind.speed) + " m/s")
            stackView.addArrangedSubview(minTempTempTextLabel)
            stackView.addArrangedSubview(tempTextLabel)
            stackView.addArrangedSubview(maxTempTextLabel)
            
            cloudAndWindStackView.addArrangedSubview(cloudTextLabel)
            cloudAndWindStackView.addArrangedSubview(windTextLabel)
            
            allStackView.addArrangedSubview(hourTextLabel)
            allStackView.addArrangedSubview(dateTextLabel)
            allStackView.addArrangedSubview(weatherTextLabel)
            allStackView.addArrangedSubview(stackView)
            allStackView.addArrangedSubview(cloudAndWindStackView)
        }
    }
}

