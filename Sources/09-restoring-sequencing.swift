//
//  09-restoring-sequencing.swift
//  CSP-tutorial
//
//  Created by fengjian on 16/3/9.
//  Copyright © 2016年 fengjian. All rights reserved.
//

import Foundation
import Venice

private struct Message {
    let str: String
    let wait: Channel<Bool>
}

private let waitForIt = Channel<Bool>() // Shared between all messages

private func boring(msg: String) -> ReceivingChannel<Message> {
    let channel = Channel<Message>()
    
    co {
        for i in 0..<Int.max {
            let sleepTime = Int(arc4random_uniform(1000) + 1).milliseconds
            
            let message = Message(str: "\(msg) \(i)  (will sleep \(Int(sleepTime * 1000)) ms)", wait: waitForIt)
            
            channel.send(message)
            nap(for: sleepTime)
            
            waitForIt.receive()!
        }
    }
    
    return channel.receivingChannel
}

private func fanIn(input1 input1: ReceivingChannel<Message>, input2: ReceivingChannel<Message>) -> ReceivingChannel<Message> {
    let channel = Channel<Message>()
    
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

//this example is not very good
public func run09() {
    let joe = boring("Joe")
    let ann = boring("Ann")
    
    let c = fanIn(input1: joe, input2: ann)
    
    for _ in 0..<5 {
        let message1 = c.receive()!
        print("\(message1.str)")
        message1.wait.send(true)
        
        let message2 = c.receive()!
        print("\(message2.str)")
        message2.wait.send(true)
    }
    
    print("You're both boring; I'm leaving.")
}