//
//  SelectLocationTableViewController.swift
//  iOSWeatherApp
//
//  Created by Vivian Phung on 7/24/19.
//  Copyright © 2019 Vivian Phung. All rights reserved.
//

import Foundation
import UIKit

class SelectLocationTableViewController: UITableViewController, UISearchBarDelegate {
    private var locations: GoogleLocationModel? = nil
    weak var delegate: SelectLocationTableViewControllerDelegate?
    
    private var spinner: UIActivityIndicatorView = {
        let spinner = UIActivityIndicatorView(style: .whiteLarge)
        spinner.translatesAutoresizingMaskIntoConstraints = false
        return spinner
    }()
    
    private var spinnerContainerView: UIView = {
        let view = UIView(frame: .zero)
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = UIColor(white: 0, alpha: 0.7)
        return view
    }()
    
    private let searchBar: UISearchBar = {
        let search = UISearchBar(frame: .zero)
        search.sizeToFit()
        return search
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .stop, target: self, action: #selector(exit))
        tableView.register(MyLocationCell.self, forCellReuseIdentifier: MyLocationCell.reuseIdentifier)
        tableView.tableHeaderView = searchBar
//        tableView.tableFooterView = spinner
        searchBar.delegate = self
//        searchController.searchBar.delegate = self
//        view.addSubview(spinnerContainerView)
//        spinnerContainerView.addSubview(spinner)
        spinnerContainerView.isHidden = true
        spinner.isHidden = true
//        NSLayoutConstraint.activate([
//            spinnerContainerView.topAnchor.constraint(equalTo: searchBar.searchBar.bottomAnchor),
//            spinnerContainerView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
//            spinnerContainerView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
//            spinnerContainerView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
//            spinner.centerYAnchor.constraint(equalTo: spinnerContainerView.centerYAnchor),
//            spinner.centerXAnchor.constraint(equalTo: spinnerContainerView.centerXAnchor)
//        ])
    }
    
    @objc func exit() {
        dismiss(animated: true, completion: nil)
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: MyLocationCell.reuseIdentifier) as! MyLocationCell
        
        guard let theLocationGuesses = locations?.predictions else {
            return cell
        }
        cell.setText(theText: theLocationGuesses[indexPath.row].text.locationName)
        return cell
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let locationGuesses = locations?.predictions else { return 0 }
        return locationGuesses.count
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let cell = tableView.cellForRow(at: indexPath) as? MyLocationCell, let text = cell.myLocationText.text {
            delegate?.changeCity(city: text)
            searchBar.resignFirstResponder()
            exit()
        }
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        apiRequest(city: searchText)
        spinnerContainerView.isHidden = false
        spinner.startAnimating()
        spinner.isHidden = false
    }

    func apiRequest(city: String) {
        APIManager.shared.googleAuto(forString: city) { [weak self] (response, error) in
            guard error == nil, let response = response else {
                print("apiRequest error: ", error)
                return
            }
            self?.locations = response
            
            DispatchQueue.main.async {
                self?.tableView.reloadData()
                self?.spinner.stopAnimating()
                self?.spinner.isHidden = true
            }
            
        }
    }
    
}

class MyLocationCell: UITableViewCell {
    static let reuseIdentifier = "aLocation"
    lazy var myLocationText: UILabel = .nonWrappingLabel(fontSize: 21)
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        // when you make something static, you need to ref the class
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.addSubview(myLocationText)
        
        NSLayoutConstraint.activate([
            myLocationText.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10),
            myLocationText.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -10),
            myLocationText.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 10),
            myLocationText.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -10),])
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setText(theText: String) {
        myLocationText.text = theText
    }
}

protocol SelectLocationTableViewControllerDelegate: class {
    func changeCity(city: String)
}
