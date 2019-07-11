//
//  FullViewController.swift
//  Project
//
//  Created by Vivian Phung on 7/10/19.
//  Copyright © 2019 Vivian Phung. All rights reserved.
//

import Foundation
import UIKit

class FullViewController: UIViewController {
    var image: UIImage? = nil
    var time: String? = nil
    var weather: String? = nil
    var myDate: String? = nil
    var row: FiveDayModel.DailyData? = nil
    var verticalSpacerConstant: CGFloat = 10
    var horizontalSpacerConstant: CGFloat = 10
    var ratioConstraint: NSLayoutConstraint?
    
    var dateTextLabel: UILabel = {
        let label = UILabel(frame: .zero)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .center
        label.font = UIFont(name:"HelveticaNeue", size: 20.0)
        label.adjustsFontSizeToFitWidth = true
        return label
    }()
    
    var fullImageView: UIImageView = {
        let image = UIImageView(frame: .zero)
        image.translatesAutoresizingMaskIntoConstraints = false
        image.contentMode = .scaleAspectFit
        image.isOpaque = false
        image.clipsToBounds = true
        return image
    }()
    
    var hourTextLabel: UILabel = {
        let label = UILabel(frame: .zero)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .center
        label.font = UIFont(name:"HelveticaNeue-Bold", size: 50.0)
        label.adjustsFontSizeToFitWidth = true
        return label
    }()
    
    var weatherTextLabel: UILabel = {
        let label = UILabel(frame: .zero)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .center
        label.font = UIFont(name:"HelveticaNeue-Bold", size: 55.0)
        label.adjustsFontSizeToFitWidth = true
        return label
    }()
    
    var maxTempTextLabel: UILabel = {
        let label = UILabel(frame: .zero)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .center
        label.font = UIFont(name:"HelveticaNeue-Bold", size: 20.0)
        label.adjustsFontSizeToFitWidth = true
        label.lineBreakMode = .byWordWrapping
        label.numberOfLines = 0
        return label
    }()
    
    var tempTextLabel: UILabel = {
        let label = UILabel(frame: .zero)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .center
        label.font = UIFont(name:"HelveticaNeue-Bold", size: 20.0)
        label.adjustsFontSizeToFitWidth = true
        label.lineBreakMode = .byWordWrapping
        label.numberOfLines = 0
        return label
    }()
    
    var minTempTempTextLabel: UILabel = {
        let label = UILabel(frame: .zero)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .center
        label.font = UIFont(name:"HelveticaNeue-Bold", size: 20.0)
        label.adjustsFontSizeToFitWidth = true
        label.lineBreakMode = .byWordWrapping
        label.numberOfLines = 0
        return label
    }()
    
    var cloudTextLabel: UILabel = {
        let label = UILabel(frame: .zero)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .center
        label.font = UIFont(name:"HelveticaNeue-Bold", size: 20.0)
        label.adjustsFontSizeToFitWidth = true
        label.lineBreakMode = .byWordWrapping
        label.numberOfLines = 0
        return label
    }()
    
    var windTextLabel: UILabel = {
        let label = UILabel(frame: .zero)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .center
        label.font = UIFont(name:"HelveticaNeue-Bold", size: 20.0)
        label.adjustsFontSizeToFitWidth = true
        label.lineBreakMode = .byWordWrapping
        label.numberOfLines = 0
        return label
    }()
    
    var stackView: UIStackView = {
        let myStackView: UIStackView = UIStackView(frame: .zero)
        myStackView.translatesAutoresizingMaskIntoConstraints = false
        myStackView.alignment = .center
        myStackView.axis = .horizontal
        myStackView.distribution = .fillEqually
        return myStackView
    }()
    
    var cloudStackView: UIStackView = {
        let myStackView: UIStackView = UIStackView(frame: .zero)
        myStackView.translatesAutoresizingMaskIntoConstraints = false
        myStackView.alignment = .center
        myStackView.axis = .horizontal
        myStackView.distribution = .fillEqually
        return myStackView
    }()
    
    var allStackView: UIStackView = {
        let myStackView: UIStackView = UIStackView(frame: .zero)
        myStackView.translatesAutoresizingMaskIntoConstraints = false
        myStackView.alignment = .center
        myStackView.axis = .vertical
        myStackView.distribution = .fillEqually
        return myStackView
    }()
    
    init() {
        // nibName is launching from a nib file or xib file
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.white
        title = "Hour Forecast"
        view.addSubview(fullImageView)
        view.addSubview(dateTextLabel)
        view.addSubview(hourTextLabel)
        view.addSubview(weatherTextLabel)
        view.addSubview(allStackView)
        
        NSLayoutConstraint.activate([
            fullImageView.topAnchor.constraint(equalTo: view.topAnchor, constant: verticalSpacerConstant),
            fullImageView.bottomAnchor.constraint(equalTo: view.centerYAnchor, constant: -verticalSpacerConstant * 2),
            fullImageView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: horizontalSpacerConstant),
            fullImageView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -horizontalSpacerConstant),
            
            hourTextLabel.topAnchor.constraint(equalTo: fullImageView.bottomAnchor, constant: verticalSpacerConstant),
            hourTextLabel.bottomAnchor.constraint(equalTo: dateTextLabel.topAnchor, constant: -verticalSpacerConstant),
            hourTextLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: horizontalSpacerConstant),
            hourTextLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -horizontalSpacerConstant),
            
            dateTextLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: horizontalSpacerConstant),
            dateTextLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -horizontalSpacerConstant),
            dateTextLabel.bottomAnchor.constraint(equalTo: weatherTextLabel.topAnchor, constant: -verticalSpacerConstant),
            
            weatherTextLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: horizontalSpacerConstant),
            weatherTextLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -horizontalSpacerConstant),
            weatherTextLabel.bottomAnchor.constraint(equalTo: allStackView.topAnchor, constant: horizontalSpacerConstant),

            allStackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: horizontalSpacerConstant),
            allStackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -horizontalSpacerConstant),
            allStackView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -horizontalSpacerConstant),
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
            setText(label: minTempTempTextLabel, text: "Min Temp: \n" + String(format: "%.2f", weatherData.main.temp_min) + "\u{00B0}")
            setText(label: tempTextLabel, text: "Temp: \n" + String(format: "%.2f", weatherData.main.temp) + "\u{00B0}")
            setText(label: maxTempTextLabel, text: "Max Temp: \n" + String(format: "%.2f", weatherData.main.temp_max) + "\u{00B0}")
            setText(label: cloudTextLabel, text: "Cloudiness: \n" + String(weatherData.clouds.all) + "%")
            setText(label: windTextLabel, text: "Wind Speed: \n" + String(weatherData.wind.speed) + " m/s")
            stackView.addArrangedSubview(minTempTempTextLabel)
            stackView.addArrangedSubview(tempTextLabel)
            stackView.addArrangedSubview(maxTempTextLabel)
            
            cloudStackView.addArrangedSubview(cloudTextLabel)
            cloudStackView.addArrangedSubview(windTextLabel)
            
            allStackView.addArrangedSubview(stackView)
            allStackView.addArrangedSubview(cloudStackView)
        }
    }
    
    func setText(label: UILabel, text: String) {
        label.text = text
    }
    
    func setImage(myView: UIImageView, image: UIImage) {
        if let constraint = ratioConstraint {
            myView.removeConstraint(constraint)
        }
        myView.image = image
        ratioConstraint = myView.heightAnchor.constraint(equalTo: myView.widthAnchor, multiplier: image.size.height / image.size.width)
        ratioConstraint?.isActive = true
    }
}
