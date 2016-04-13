//
//  19-google-search-2.1.swift
//  CSP-tutorial
//
//  Created by fengjian on 16/3/9.
//  Copyright © 2016年 fengjian. All rights reserved.
//

import Foundation
import Venice

private func google(query: String) -> Array<GoogleSearchResult> {
    let channel = Channel<GoogleSearchResult>()
    
    co(channel.send(web(query)))
    co(channel.send(image(query)))
    co(channel.send(video(query)))
    
    var results = Array<GoogleSearchResult>()
    
    let timeout = Timer(timingOut: 800.milliseconds.fromNow()).channel
    
    var done = false
    for _ in 0..<3 {
        if done == true {
            break
        }
        
        select { when in
            when.receive(from: channel) { value in
                results.append(value)
            }
            
            when.receive(from: timeout) { _ in
                print("timeout.")
                done = true
            }
        }
    }
    return results
}

public func run19() {
    var result: Array<GoogleSearchResult>?
    
    time("google search v2.1, use time: ") { () -> () in
        result = google("CSP")
    }
    
    result?.log()
}