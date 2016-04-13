//
//  11-timeout.swift
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
            nap(for: sleepTime)
            
            channel.send("\(msg) \(i)  (will sleep \(Int(sleepTime * 1000)) ms)")
        }
    }
    
    return channel.receivingChannel
}


public func run11() {
    let joe = boring("Joe")
    
    var done = false
    while !done {
        select { when in
            when.receive(from: joe) { value in
                print("\(value)")
            }
            
            when.timeout(800.millisecond.fromNow()) {
                print("You are too slow.")
                done = true
            }
        }
    }
    
    print("You're boring; I'm leaving.")
}
