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
