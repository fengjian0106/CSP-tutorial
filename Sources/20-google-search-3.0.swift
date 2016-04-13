//
//  20-google-search-3.0.swift
//  CSP-tutorial
//
//  Created by fengjian on 16/3/9.
//  Copyright © 2016年 fengjian. All rights reserved.
//

import Foundation
import Venice


let web1 = fakeSearch("web1")
let web2 = fakeSearch("web2")
let image1 = fakeSearch("image1")
let image2 = fakeSearch("image2")
let video1 = fakeSearch("video1")
let video2 = fakeSearch("video2")


private func first(query query: String, replicas: ((String) -> GoogleSearchResult)...) -> GoogleSearchResult {
    let channel = Channel<GoogleSearchResult>()
    
    for search in replicas {
        co(channel.send(search(query)))
    }
    
    return channel.receive()!
}


private func google(query: String) -> Array<GoogleSearchResult> {
    let channel = Channel<GoogleSearchResult>()
    
    co {
        channel.send(first(query: query, replicas: web1, web2))
    }
    
    co {
        channel.send(first(query: query, replicas: image1, image2))
    }
    
    co {
        channel.send(first(query: query, replicas: video1, video2))
    }
    
    var results = Array<GoogleSearchResult>()
    
    let timeout = Timer(timingOut: 1000.milliseconds.fromNow()).channel
    
    var done = false
    for _ in 0..<3 {
        if done == true {
            break
        }
        
        select { when in
            when.receive(from: channel) { value in
                //print("receive \(value)")
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


public func run20() {
    var result: Array<GoogleSearchResult>?
    
    time("google search v3.0, use time: ") { () -> () in
        result = google("CSP")
    }
    
    result?.log()
}
