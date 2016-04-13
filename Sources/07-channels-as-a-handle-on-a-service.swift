//
//  07-channels-as-a-handle-on-a-service.swift
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


public func run07() {
    let joe = boring("Joe")
    let ann = boring("Ann")
    
    for _ in 0..<5 {
        print("\(joe.receive()!)")
        print("\(ann.receive()!)")
    }
    
    print("You're both boring; I'm leaving.")
}