//
//  05-channel-with-boring.swift
//  CSP-tutorial
//
//  Created by fengjian on 16/3/8.
//  Copyright © 2016年 fengjian. All rights reserved.
//

import Foundation
import Venice

private func boring(msg msg: String, channel: SendingChannel<String> ) {
    for i in 0..<Int.max {
        channel.send("\(msg) \(i)")
        nap(for: Int(arc4random_uniform(1000) + 1).milliseconds)
    }
}

public func run05() {
    let channel = Channel<String>()
    
    co {
        boring(msg: "co a less boring func", channel: channel.sendingChannel)
    }
    
    for _ in 0..<5 {
        print("You say: \(channel.receivingChannel.receive()!)")
    }
    
    print("You're boring; I'm leaving.")
    channel.close()
}
