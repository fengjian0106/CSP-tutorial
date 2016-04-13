//
//  15-daisy-chain.swift
//  CSP-tutorial
//
//  Created by fengjian on 16/3/9.
//  Copyright © 2016年 fengjian. All rights reserved.
//

import Foundation
import Venice

private func f(left left: Channel<Int>, right: Channel<Int>) {
    left.send(right.receive()! + 1)
}

public func run15() {
    let leftMost = Channel<Int>()
    
    var right = leftMost
    var left = leftMost
    
    for _ in 0..<10000 {
        right = Channel<Int>()
        co {
            f(left: left, right: right)
        }
        left = right
    }
    
    co {
        right.send(1)
    }
    
    print("Joe says: \(leftMost.receive()!)")
    
    print("You're boring; I'm leaving.")
}