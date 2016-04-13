//
//  03-co-boring.swift
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
        nap(for: Int(arc4random_uniform(1000) + 1).milliseconds)//sleep
    }
}

public func run03() {
    co {
        boring("co a less boring func")
    }
    
    /**
    //if do not want run03() finish, run the loop below
    for i in 0..<Int.max {
        yield
    }
    */
    print("run03() will return")
}


/**
/////////////////////////////////////////////////////////
private func boringWrong(msg: String) {
    for i in 0..<Int.max {
        print("\(msg) \(i)")
        
        //usleep is not right func for sleep, so must call yield by myself
        usleep(1000 * (arc4random_uniform(1000) + 1))
        //yield
    }
}


public func run03Wrong() {
    co(boringWrong("co a less boring func"))
   
    print("run03Wrong() will return")
}
*/