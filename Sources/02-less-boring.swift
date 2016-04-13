//
//  02-less-boring.swift
//  CSP-tutorial
//
//  Created by fengjian on 16/3/8.
//  Copyright © 2016年 fengjian. All rights reserved.
//

import Foundation

private func boring(msg: String) {
    for i in 0..<Int.max {
        print("\(msg) \(i)")
        usleep(1000 * (arc4random_uniform(1000) + 1))
    }
}

public func run02() {
    boring("this is a less boring func")
}