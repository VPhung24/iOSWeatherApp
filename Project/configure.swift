//
//  configure.swift
//  iOSWeatherApp
//
//  Created by Vivian Phung on 7/12/19.
//  Copyright © 2019 Vivian Phung. All rights reserved.
//

import Foundation

public protocol Configurable { }

public extension Configurable {
    func configured(transform: (inout Self) throws -> Void) rethrows -> Self {
        var mutableSelf = self
        try transform(&mutableSelf)
        return mutableSelf
    }
}

extension NSObject: Configurable { }
extension Array: Configurable { }
extension JSONDecoder: Configurable { }
extension JSONEncoder: Configurable { }
