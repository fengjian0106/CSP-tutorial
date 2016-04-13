//
//  04-co-boring.swift
//  CSP-tutorial
//
//  Created by fengjian on 16/3/8.
//  Copyright © 2016年 fengjian. All rights reserved.
//

import Foundation
import Venice

private func boring(msg: String) {
    for i in 0..<Int.max {
        print("\(msg) \(i)")
        nap(for: Int(arc4random_uniform(1000) + 1).milliseconds)
    }
}

public func run04() {
    co(boring("co a less boring func"))
    print("I'm listening")
    nap(for: 2.second)
    print("You're boring; I'm leaving.")
}