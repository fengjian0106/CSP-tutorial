//
//  01-boring.swift
//  CSP-tutorial
//
//  Created by fengjian on 16/3/8.
//  Copyright © 2016年 fengjian. All rights reserved.
//

import Foundation

private func boring(msg: String) {
    for i in 0...10 {
        print("\(msg) \(i)")
        usleep(100)
    }
}

public func run01() {
    boring("this is a boring func")
}