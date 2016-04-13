//
//  08-fan-in.swift
//  CSP-tutorial
//
//  Created by fengjian on 16/3/9.
//  Copyright © 2016年 fengjian. All rights reserved.
//

import Foundation
import Venice

private func boring(msg: String) -> ReceivingChannel<String> {
    let channel = Channel<String>()
    
    co {
        for i in 0..<Int.max {
            let sleepTime = Int(arc4random_uniform(1000) + 1).milliseconds
            channel.send("\(msg) \(i)  (will sleep \(Int(sleepTime * 1000)) ms)")
            nap(for: sleepTime)
        }
    }
    
    return channel.receivingChannel
}

private func fanIn(input1 input1: ReceivingChannel<String>, input2: ReceivingChannel<String>) -> ReceivingChannel<String> {
    let channel = Channel<String>()
    
    co {
        while true {
            channel.send(input1.receive()!)
        }
    }
    
    co {
        while true {
            channel.send(input2.receive()!)
        }
    }
    
    return channel.receivingChannel
}

public func run08() {
    let joe = boring("Joe")
    let ann = boring("Ann")
    
    let c = fanIn(input1: joe, input2: ann)
    
    for _ in 0..<10 {
        print("\(c.receive()!)")
    }
    
    print("You're both boring; I'm leaving.")
}