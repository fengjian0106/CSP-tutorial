//
//  13-quit-channel.swift
//  CSP-tutorial
//
//  Created by fengjian on 16/3/9.
//  Copyright © 2016年 fengjian. All rights reserved.
//

import Foundation
import Venice

private func boring(msg msg: String, quit: ReceivingChannel<Bool>) -> ReceivingChannel<String> {
    let channel = Channel<String>()
    
    co {
        forSelect { when, done in
            let sleepTime = Int(arc4random_uniform(1000) + 1).milliseconds
            nap(for: sleepTime)
            
            when.send("\(msg), and will sleep \(Int(sleepTime * 1000)) ms", to: channel) {
                //print("sent value")
            }
            when.receive(from: quit) { _ in
                done()
            }
        }
        
        channel.close()
    }
    
    return channel.receivingChannel
}

public func run13() {
    let quit = Channel<Bool>()
    let joe = boring(msg: "Joe", quit: quit.receivingChannel)
    
    for _ in 0..<Int64(arc4random_uniform(10) + 1) {
        print("\(joe.receive()!)")
    }
    
    quit.send(true)
    
    print("You're boring; I'm leaving.")
}