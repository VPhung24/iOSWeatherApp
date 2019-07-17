//
//  ChangeCityViewController.swift
//  Project
//
//  Created by Vivian Phung on 7/11/19.
//  Copyright © 2019 Vivian Phung. All rights reserved.
//

import Foundation
import UIKit

protocol ChangeCityDelegate: class {
    func changeCity(city: String)
}

class ChangeCityViewController: BaseViewController {
    var myTitle: String = "Change the city"
    var verticalSpacerConstant: CGFloat = 10
    var horizontalSpacerConstant: CGFloat = 10
    weak var delegate: ChangeCityDelegate?
    
    var submitButton: UIButton = {
        var button: UIButton = UIButton()
        button.setTitle("Submit", for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.titleLabel?.font = UIFont(name: "Helvetica", size: 24)
        button.addTarget(self, action: #selector(submit), for: .touchDown)
        button.backgroundColor = UIColor(red: 10.00/255, green: 132.00/255, blue: 255.00/255, alpha: 1.00)
        button.titleLabel?.textColor = .black
        return button
    }()
    
    @objc func submit() {
        let text = changeTextField.text ?? ""
        delegate?.changeCity(city: text)
        exit()
    }
    
    @objc func exit() {
        dismiss(animated: true, completion: nil)
    }
    
    lazy var changeTextField: UITextField = .newTextField(myText: "City Name")
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        title = myTitle
        
        view.addSubview(changeTextField)
        view.addSubview(submitButton)
        
        NSLayoutConstraint.activate([
            changeTextField.heightAnchor.constraint(equalToConstant: verticalSpacerConstant * 3),
            changeTextField.bottomAnchor.constraint(equalTo: view.centerYAnchor, constant: -verticalSpacerConstant),
            changeTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: horizontalSpacerConstant),
            changeTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -horizontalSpacerConstant),
            
            submitButton.topAnchor.constraint(equalTo: changeTextField.bottomAnchor, constant: verticalSpacerConstant),
            submitButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: horizontalSpacerConstant),
            submitButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -horizontalSpacerConstant),
            submitButton.heightAnchor.constraint(equalToConstant: verticalSpacerConstant * 4)
            ])
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "X", style: .plain, target: self, action: #selector(exit))
    }
}
