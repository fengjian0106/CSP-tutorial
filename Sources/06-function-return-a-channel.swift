//
//  06-function-return-a-channel.swift
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
            channel.send("\(msg) \(i)")
            nap(for: Int(arc4random_uniform(1000) + 1).milliseconds)
        }
    }
    
    return channel.receivingChannel
}

public func run06() {
    let receivingChannel = boring("co a less boring func")
    
    for _ in 0..<5 {
        print("You say: \(receivingChannel.receive()!)")
    }
    
    print("You're boring; I'm leaving.")
}