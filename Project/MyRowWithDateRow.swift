//
//  MyRowWithDateRow.swift
//  Project
//
//  Created by Vivian Phung on 7/9/19.
//  Copyright © 2019 Vivian Phung. All rights reserved.
//

import Foundation
import UIKit

class MyRowWithDate: UITableViewCell {
    lazy var myDateText: UILabel = nonWrappingLabel(fontSize: 20)
    lazy var myWeatherText: UILabel = nonWrappingLabel(fontSize: 30)
    lazy var myPhoto: UIImageView = newImageView()
    private let verticalSpacerConstant: CGFloat = 10
    private let horizontalSpacerConstant: CGFloat = 10
    static let reuseIdentifier = "DateRow"
    private var ratioConstraint: NSLayoutConstraint?
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        // when you make something static, you need to ref the class
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        contentView.addSubview(myPhoto)
        contentView.addSubview(myWeatherText)
        contentView.addSubview(myDateText)
        
        // constraints
        NSLayoutConstraint.activate([
            myPhoto.topAnchor.constraint(equalTo: contentView.topAnchor, constant: verticalSpacerConstant),
            myPhoto.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -verticalSpacerConstant),
            myPhoto.leadingAnchor.constraint(equalTo: myDateText.trailingAnchor, constant: horizontalSpacerConstant),
            myPhoto.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -horizontalSpacerConstant),
            
            myDateText.topAnchor.constraint(equalTo: contentView.topAnchor, constant: verticalSpacerConstant),
            myDateText.bottomAnchor.constraint(equalTo: myWeatherText.topAnchor, constant: -verticalSpacerConstant),
            myDateText.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: horizontalSpacerConstant),
            
            myWeatherText.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -verticalSpacerConstant),
            myWeatherText.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: horizontalSpacerConstant),
            myWeatherText.trailingAnchor.constraint(equalTo: myPhoto.leadingAnchor, constant: -horizontalSpacerConstant),
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
    
    func setCellText(newText: String?, date: String?) {
        myWeatherText.text = newText
        myDateText.text = findDateInAMPM(date: date!)
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
