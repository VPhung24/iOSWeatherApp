//
//  MyRowWithDateRow.swift
//  iOSWeatherApp
//
//  Created by Vivian Phung on 7/9/19.
//  Copyright © 2019 Vivian Phung. All rights reserved.
//

import Foundation
import UIKit

class MyRowWithDate: UITableViewCell {
    lazy var myHourText: UILabel = .nonWrappingLabel(fontSize: 20)
    lazy var myWeatherText: UILabel = {
        var label: UILabel = .nonWrappingLabel(fontSize: 21)
        label.font = UIFont(name:"HelveticaNeue-Bold", size: 30)
        return label
    }()
    lazy var myTempLabel: UILabel = .nonWrappingLabel(fontSize: 21)
    lazy var infoStackView: UIStackView = .newStackView()
    lazy var myPhoto: UIImageView = .newImageView()
    private let verticalSpacerConstant: CGFloat = 10
    private let horizontalSpacerConstant: CGFloat = 10
    static let reuseIdentifier = "DateRow"
    private var ratioConstraint: NSLayoutConstraint?
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        // when you make something static, you need to ref the class
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        contentView.addSubview(myPhoto)
        contentView.addSubview(myWeatherText)
        contentView.addSubview(infoStackView)
        infoStackView.addArrangedSubview(myHourText)
        infoStackView.addArrangedSubview(myTempLabel)
        // constraints
        NSLayoutConstraint.activate([
            myPhoto.topAnchor.constraint(equalTo: contentView.topAnchor, constant: verticalSpacerConstant),
            myPhoto.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -verticalSpacerConstant),
            myPhoto.leadingAnchor.constraint(equalTo: myWeatherText.trailingAnchor, constant: horizontalSpacerConstant),
            myPhoto.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -horizontalSpacerConstant),
            
            infoStackView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: verticalSpacerConstant),
            infoStackView.bottomAnchor.constraint(equalTo: myWeatherText.topAnchor, constant: -verticalSpacerConstant),
            infoStackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: horizontalSpacerConstant),
            infoStackView.trailingAnchor.constraint(equalTo: myPhoto.leadingAnchor, constant: -horizontalSpacerConstant),
            
            myWeatherText.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: horizontalSpacerConstant),
            myWeatherText.trailingAnchor.constraint(equalTo: myPhoto.leadingAnchor, constant: -horizontalSpacerConstant),
            myWeatherText.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -verticalSpacerConstant)
            
            ])
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    /// set image with height
    func setImage(newImage: UIImage) {
        if let constraint = ratioConstraint {
            myPhoto.removeConstraint(constraint)
        }
        myPhoto.image = newImage
        ratioConstraint = myPhoto.heightAnchor.constraint(equalTo: myPhoto.widthAnchor, multiplier: imageRatioFun(image: newImage))
        ratioConstraint?.isActive = true
    }
    
    func setCellText(newText: String, date: String, theTemp: String) {
        myWeatherText.text = newText
        myHourText.text = findDateInAMPM(date: date)
        myTempLabel.text = theTemp + "\u{00B0}"
    }
    
    /// takes in time formatted as "HH:mm:ss" and returns as "h a"
    private func findDateInAMPM(date: String) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "HH:mm:ss"
        let theDate = dateFormatter.date(from: date)
        dateFormatter.dateFormat = "h a"
        return dateFormatter.string(from: theDate!)
    }
    
    public func imageRatioFun(image: UIImage) -> CGFloat {
        return image.size.height / image.size.width
    }
}
