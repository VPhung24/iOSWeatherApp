//
//  BaseViewController.swift
//  Project
//
//  Created by Vivian Phung on 7/11/19.
//  Copyright © 2019 Vivian Phung. All rights reserved.
//

import Foundation
import UIKit

class BaseViewController: UIViewController {
    init() {

        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
}

func setText(label: UILabel, text: String) {
    label.text = text
}

func setImage(myView: UIImageView, image: UIImage) {
    myView.image = image
}

func nonWrappingLabel(fontSize: CGFloat) -> UILabel {
    let label = UILabel(frame: .zero)
    label.translatesAutoresizingMaskIntoConstraints = false
    label.textAlignment = .center
    label.font = UIFont(name:"HelveticaNeue", size: fontSize)
    label.adjustsFontSizeToFitWidth = true
    return label
}

func wrappingLabel(fontSize: CGFloat) -> UILabel {
    let label = nonWrappingLabel(fontSize: fontSize)
    label.lineBreakMode = .byWordWrapping
    label.numberOfLines = 0
    return label
}

func newStackView(axis: NSLayoutConstraint.Axis) -> UIStackView {
    let myStackView: UIStackView = UIStackView(frame: .zero)
    myStackView.translatesAutoresizingMaskIntoConstraints = false
    myStackView.alignment = .fill
    myStackView.axis = axis
    myStackView.distribution = .equalCentering
    return myStackView
}

func newTextField(myText: String) -> UITextField {
    let text = UITextField(frame: .zero)
    text.translatesAutoresizingMaskIntoConstraints = false
    text.borderStyle = .roundedRect
    text.textColor = .black
    text.backgroundColor = .white
    text.placeholder = myText
    return text
}

/// formats dates like 2019-07-09 to
func myDateFormatter(dayDate: String) -> String {
    let dateFormatter = DateFormatter()
    dateFormatter.dateFormat = "yyyy-MM-dd"
    let theDate = dateFormatter.date(from: dayDate)
    dateFormatter.dateFormat = "MMM dd, yyy"
    return dateFormatter.string(from: theDate!)
}

func newImageView() -> UIImageView {
    let image = UIImageView(frame: .zero)
    image.translatesAutoresizingMaskIntoConstraints = false
    image.contentMode = .scaleAspectFit
    image.isOpaque = false
    image.clipsToBounds = true
    return image
}
