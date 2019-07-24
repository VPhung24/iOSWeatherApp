//
//  Helper.swift
//  iOSWeatherApp
//
//  Created by Vivian Phung on 7/16/19.
//  Copyright © 2019 Vivian Phung. All rights reserved.
//

import Foundation
import UIKit

extension UILabel {
    /// basic non-Wrapping Label
    static func nonWrappingLabel(fontSize: CGFloat = 12) -> UILabel  {
        let label = UILabel(frame: .zero)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .center
        label.font = UIFont(name:"HelveticaNeue", size: fontSize)
        label.adjustsFontSizeToFitWidth = true
        return label
    }
    
    /// basic Wrapping Label
    static func wrappingLabel(fontSize: CGFloat = 12) -> UILabel {
        let label = nonWrappingLabel(fontSize: fontSize)
        label.lineBreakMode = .byWordWrapping
        label.numberOfLines = 0
        return label
    }
}

extension UIStackView {
    /// basic stack view
    static func newStackView(axis: NSLayoutConstraint.Axis = .horizontal) -> UIStackView {
        let myStackView: UIStackView = UIStackView(frame: .zero)
        myStackView.translatesAutoresizingMaskIntoConstraints = false
        myStackView.alignment = .fill
        myStackView.axis = axis
        myStackView.distribution = .equalCentering
        return myStackView
    }
}

extension UITextField {
    /// basic text field
    static func newTextField(myText: String) -> UITextField {
        let text = UITextField(frame: .zero)
        text.translatesAutoresizingMaskIntoConstraints = false
        text.borderStyle = .roundedRect
        text.textColor = .black
        text.backgroundColor = .white
        text.placeholder = myText
        return text
    }
}

extension UIImageView {
    static func newImageView() -> UIImageView {
        let image = UIImageView(frame: .zero)
        image.translatesAutoresizingMaskIntoConstraints = false
        image.contentMode = .scaleAspectFit
        image.isOpaque = false
        image.clipsToBounds = true
        return image
    }
}
