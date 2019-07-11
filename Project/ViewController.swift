//
//  ViewController.swift
//  Understanding
//
//  Created by Vivian Phung on 6/13/19.
//  Copyright © 2019 Vivian Phung. All rights reserved.
//

import UIKit

let cellIdentifier = "mainCell"

class ViewController: UIViewController {
    private var data: WeatherDataModel? = nil
    private var image: UIImage? = nil
    
    // vp: start with private if you need it elsewhere change. Lazy when everything is complied it wont create the variable until its called for the first time and only once
    private lazy var myTableView: UITableView = {
        let tableView = UITableView(frame: .zero)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.register(MyCell.self, forCellReuseIdentifier: MyCell.thisCellIdenitifier)
        return tableView
    }()
    
    init() {
        // nibName is launching from a nib file or xib file
        super.init(nibName: nil, bundle: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        view.addSubview(myTableView)
        
        NSLayoutConstraint.activate([
            myTableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            myTableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            myTableView.topAnchor.constraint(equalTo: view.topAnchor),
            myTableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
            ])
        apiRequest(city: "San Francisco", weatherEndpoint: .GetWeather)
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    func apiRequest(city: String, weatherEndpoint: WeatherEndpoint) {
        APIManager.shared.getCurrentWeather(forCity: city) { [weak self] (response, error) in
            guard error == nil, let response = response else { return }
            
            self?.data = response
            
            DispatchQueue.main.async {
                self?.myTableView.reloadData()
            }
            self?.downloadImage()
        }
    }
    
    func downloadImage() {
        let baseURL: String = "https://openweathermap.org/img/wn/"
        let suffix: String = "@2x.png"
        
        if let imageName: String = self.data?.weather.first?.icon {
            let imageURL = baseURL + imageName + suffix
            let url = URL(string: imageURL)
            
            URLSession.shared.dataTask(with: url!) { [weak self] (data, response, error) in
                guard error == nil, let data = data else {
                    print(error)
                    return
                }
                
                DispatchQueue.main.async {
                    self?.image = UIImage(data: data)
                    self?.myTableView.reloadData()
                }
            }.resume()
        }
    }
    
}

// managing selection, ...
// not manditory
extension ViewController: UITableViewDelegate {
    
}

// need if table view
extension ViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: MyCell.thisCellIdenitifier) as! MyCell
        if let image = image {
            cell.setImage(newImage: image)
        }
        cell.setText(newText: data?.weather.first?.description)
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
}

class MyCell: UITableViewCell {
    static let thisCellIdenitifier = "ThisIsACell"
    private let verticalSpacerConstant: CGFloat = 10
    private let horizontalSpacerConstant: CGFloat = 10
    private var ratioConstraint: NSLayoutConstraint?
    
    private lazy var myImage: UIImageView = {
        let image = UIImageView(frame: .zero)
        image.translatesAutoresizingMaskIntoConstraints = false
        image.contentMode = .scaleAspectFit
        image.isOpaque = false
        image.clipsToBounds = true
        return image
    }()
    
    private lazy var myText: UILabel = {
        let text = UILabel(frame: .zero)
        text.translatesAutoresizingMaskIntoConstraints = false
        return text
    }()
    
    func imageRatioFun(image: UIImage) -> CGFloat {
        return image.size.height / image.size.width
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        // when you make something static, you need to ref the class
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        contentView.addSubview(myImage)
        contentView.addSubview(myText)
        
        // leading is hor
        NSLayoutConstraint.activate([
            myImage.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: horizontalSpacerConstant),
            myImage.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -horizontalSpacerConstant),
            myImage.topAnchor.constraint(equalTo: contentView.topAnchor, constant: verticalSpacerConstant),
            
            myText.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: horizontalSpacerConstant),
            myText.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -horizontalSpacerConstant),
            myText.topAnchor.constraint(equalTo: myImage.bottomAnchor, constant: verticalSpacerConstant),
            myText.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -verticalSpacerConstant),
            ])
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    func setImage(newImage: UIImage) {
        if let constraint = ratioConstraint {
            myImage.removeConstraint(constraint)
        }
        myImage.image = newImage
        ratioConstraint = myImage.heightAnchor.constraint(equalTo: myImage.widthAnchor, multiplier: imageRatioFun(image: newImage))
        ratioConstraint?.isActive = true
    }
    
    func setText(newText: String?) {
        myText.text = newText
    }
    
}

